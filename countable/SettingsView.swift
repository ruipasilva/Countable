//
//  SettingsView.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import SwiftUI

struct SettingsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var counter: Counter
    
    @AppStorage("colorTheme") var colorTheme = Color.mainTheme
    
    var color: Color
    
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 48))
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Set Visitors Limit", isOn: $counter.areVisitorsLimited.animation())
                        
                    .onTapGesture {
                        print(counter.areVisitorsLimited)
                    }
                    .accentColor(Color("Tint"))
                    
                    if counter.areVisitorsLimited {
                        Section {
                            HStack {
                                Text("Limit")
                            Picker(selection: $counter.visitorLimit, label: Text("Limit")) {
                                ForEach(0..<1000) { number in
                                    Text("\(number)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxWidth: .infinity)
                        }
                        }
                    }
                }
                Section(header: Text("Select color").bold()) {
                    LazyVGrid(columns: colorColumns) {
                        ForEach(Counter.colors, id: \.self) { item in
                            colorButton(for: item)
                        }
                    }
                }
                .padding()
            }
            //            .background(Color.systemGroupedBackground)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button("Done") {
                                        presentationMode.wrappedValue.dismiss()
                                    })
        }.accentColor(colorTheme)
    }
    
    func colorButton(for item: Color) -> some View {
        ZStack {
            Circle()
                .foregroundColor(item)
                .aspectRatio(1, contentMode: .fill)
                .cornerRadius(10)
            
            if item == colorTheme {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {

            colorTheme = item
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(counter: Counter(), color: Color.mainTheme)
    }
}
