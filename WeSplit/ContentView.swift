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
    @State private var numberOfpeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfpeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfpeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section(header: Text("How much of a tip do you want to leave?").textCase(.none)) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(totalPerPerson, specifier: "%.2f")")
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
