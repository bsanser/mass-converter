//
//  ContentView.swift
//  MassConverter
//
//  Created by Barbara Sanchis Server on 28/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var value = ""
    @State private var initialUnit = 0
    @State private var finalUnit = 3
    
    
    let units: [String] = ["kg", "gr", "oz","lb"]
    
    var getOutput: Double {
        var output = ""
        var input = Measurement(value: Double(value) ?? 0, unit: UnitMass.kilograms )
        
        switch initialUnit {
            case 0:
                let valueToConvert = Measurement(value: Double(value) ?? 0, unit: UnitMass.kilograms)
                input = valueToConvert
            case 1:
                let valueToConvert = Measurement(value: Double(value) ?? 0, unit: UnitMass.grams)
                input = valueToConvert

            case 2:
                let valueToConvert = Measurement(value: Double(value) ?? 0, unit: UnitMass.ounces)
                input = valueToConvert

            case 3:
                let valueToConvert = Measurement(value: Double(value) ?? 0, unit: UnitMass.pounds)
                input = valueToConvert

        default:
            input = Measurement(value: Double(value) ?? 0, unit: UnitMass.kilograms )
        }
        
        switch finalUnit {
            case 0:
                output = String(describing: input.converted(to: UnitMass.kilograms))
            case 1:
                output = String(describing: input.converted(to: UnitMass.grams))
        
            case 2:
                output = String(describing: input.converted(to: UnitMass.ounces))
        
            case 3:
                output = String(describing: input.converted(to: UnitMass.pounds))
        
            default:
                output = String(describing: input.converted(to: UnitMass.pounds))
        }
        
        let splitOutput = output.components(separatedBy: " ")
        
        return Double(splitOutput[0]) ?? 0.0
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount to convert")){
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Initial Unit")) {
                    Picker("Initial Unit", selection: $initialUnit) {
                        ForEach(0..<units.count ) {
                            Text(units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Final Unit")) {
                    Picker("Final Unit", selection: $finalUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion")){
                    Text("\(value) \(units[initialUnit]) is \(getOutput, specifier: "%.2f") \(units[finalUnit])")
                }
                
            }
            .navigationTitle(Text("Mass Converter"))
                .ignoresSafeArea()
        }
     
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
