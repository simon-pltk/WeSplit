import SwiftUI


// THINGS THE APP NEEDS
// Cost of the check, how many people sharing the cost, and how much tip they want to leave

struct ContentView: View {
    @State var cost = 0.0
    @State var numPeople = 0
    @State  var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let percentOptions = [15, 18, 20, 22, 25, 0]
    
    var totalPerPerson: Double {
        let pplCount = Double(numPeople + 2)
        let tip = cost / 100 * Double(tipPercentage)
        
        let total = cost + tip
        
        return total / pplCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Please enter the subtotal:") {
                    TextField("Amount", value: $cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                }
        
                
                Section("How many people are there?") {
                    Picker("Number of People", selection: $numPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much of a tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(percentOptions, id: \.self) {
                            Text($0 , format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Text("Total with tip: \(totalPerPerson * Double(numPeople+2))")
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
