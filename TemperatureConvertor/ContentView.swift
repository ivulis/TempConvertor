//
//  ContentView.swift
//  TemperatureConvertor
//
//  Created by jazeps.ivulis on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var inputIsFocused: Bool
    
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var outputNumber: Double {
        var baseUnitNumber: Measurement<UnitTemperature> = Measurement(value: 0, unit: .celsius)
        var convertedNumber: Measurement<UnitTemperature> = Measurement(value: 32, unit: .fahrenheit)
        
        switch inputUnit {
        case "Celsius":
            baseUnitNumber = Measurement(value: inputNumber, unit: .celsius)
        case "Fahrenheit":
            baseUnitNumber = Measurement(value: inputNumber, unit: .fahrenheit).converted(to: .celsius)
        case "Kelvin":
            baseUnitNumber = Measurement(value: inputNumber, unit: .kelvin).converted(to: .celsius)
        default: break
        }
        
        switch outputUnit {
        case "Celsius":
            convertedNumber = baseUnitNumber
        case "Fahrenheit":
            convertedNumber = baseUnitNumber.converted(to: UnitTemperature.fahrenheit)
        case "Kelvin":
            convertedNumber = baseUnitNumber.converted(to: .kelvin)
        default: break
        }
        
        return convertedNumber.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input number", value: $inputNumber, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input number")
                }
                
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input unit")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output unit")
                }
                
                Section {
                    Text("\(outputNumber, specifier: "%.2f")")
                } header: {
                    Text("Output number")
                }
            }
            .navigationTitle("TempConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
