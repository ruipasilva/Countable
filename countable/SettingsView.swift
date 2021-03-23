//
//  SettingsView.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showsPicker = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var counter: Counter
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 52))
    ]
    
    var limitBody: some View {
        VStack {
            HStack {
                Text("Limit")
                Spacer()
                Text("\(counter.visitorLimit)")
                    .foregroundColor(Color("\(counter.colorTheme)"))
                    .padding(.trailing,4)
            }
            .contentShape(Rectangle())
            .animation(nil)
            .onTapGesture {
                showsPicker.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Set Visitors Limit", isOn: $counter.areVisitorsLimited.animation())
                    
                    if counter.areVisitorsLimited {
                        limitBody
                            .animation(.default)
                        
                        
                        CollapsableWheelPicker(
                            "",
                            showsPicker: $showsPicker,
                            selection: $counter.visitorLimit
                        ) {
                            ForEach(0..<1000) { number in
                                Text("\(number)")
                                
                            }
                        }
                    }
                }
                Section(header: Text("Theme")) {
                    LazyVGrid(columns: colorColumns) {
                        ForEach(Counter.colors, id: \.self) { item in
                            colorButton(for: item)
                                .padding(4)
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    
                }
                
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button("Done") {
                                        presentationMode.wrappedValue.dismiss()
                                    })
        }.accentColor(Color("\(counter.colorTheme)"))
    }
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color("\(item)"))
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(10)
            
            if item == counter.colorTheme {
                Image(systemName: "checkmark")
                    .font(.title3)
                    .foregroundColor(.white)
                    
            }
        }
        .onTapGesture {
            counter.colorTheme = item
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(counter: Counter())
    }
}


