//
//  SettingsView.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    @State private var showsPicker = false
    @State private var isScreenAlwaysOn = false 
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var counter: Counter
    
    let colorColumns = [GridItem(.adaptive(minimum: 52))]
    
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
                Section(footer: Text("Turn this option on if you need to prevent the screen from dimming when no touch input is detected for a while. Turn this off to conserve battery.")){
                    Toggle("Display Always On", isOn: $isScreenAlwaysOn)
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
    func screenOn() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func isAlwaysOn() {
        if isScreenAlwaysOn == true {
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(counter: Counter())
    }
}


