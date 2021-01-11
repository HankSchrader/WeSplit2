//
//  ContentView.swift
//  WeSplit
//
//  Created by Sara Nicole Mikac on 1/10/21.
//

//Forms are scrolling
/*
 Apple recommends @state vars be private. They should only be used
 for simple cases.
 https://www.hackingwithswift.com/books/ios-swiftui/creating-pickers-in-a-form
 */
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfpeople = "2"
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: (perPerson: Double, grandTotal: Double) {
        let peopleCount = Double(Int(numberOfpeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return (amountPerPerson, grandTotal)
    }
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfpeople).keyboardType(.numberPad)
                    
                }
                Section(header: Text("How much of a tip do you want to leave?").textCase(.none)) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Grand Total").textCase(.none))  {
                    Text("\(total.grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount owed by each individual").textCase(.none)) {
                    Text("\(total.perPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("We Split")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
