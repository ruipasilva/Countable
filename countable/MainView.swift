//
//  MainView.swift
//  countable
//
//  Created by Rui Silva on 06/03/2021.
//

import SwiftUI
import CoreHaptics

struct MainView: View {

    @State private var engine: CHHapticEngine?
    @State private var fontSize: CGFloat = 170
    @State private var isShowingSettings = false
    
    @ObservedObject var counter: Counter
    
    @AppStorage("colorTheme") var colorTheme = Color.mainTheme 
    
    
    var settingsButton: some View {
            Button(action: {
                isShowingSettings.toggle()
            }, label: {
                Image(systemName: "gearshape.fill")
            })
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(colorTheme)
                .frame(width: 46, height: 46)
                .background(colorTheme.opacity(0.1))
                .cornerRadius(40)
    }
    
    var resetButton: some View {
        VStack {
            Button("Reset") {
                counter.counter = 0
                complexSuccess()
                
                print(counter.counter)
                print(counter.visitorLimit)
                print(counter.areVisitorsLimited)
            }
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(colorTheme)
                .frame(width: 90, height: 46)
                .background(colorTheme.opacity(0.1))
                .cornerRadius(40)
        }
    }
    
    var limitReached: some View {
        VStack {
            Text("Reached Visitors Limit")
                .padding(.vertical, 8)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.systemRed)
                .background(Color.systemRed.opacity(0.1))
                .cornerRadius(40)
        }.animation(.default)
    }
    
    var tooManyVisitorsText: Text {
        Text("\(counter.counter - counter.visitorLimit)")
            .bold()
    }
    
    var tooManyVisitors: some View {
        VStack {
            Text("\(tooManyVisitorsText) visitors over the limit")
                .padding(.vertical, 8)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.systemRed)
                .background(Color.systemRed.opacity(0.1))
                .cornerRadius(40)
        }
    }
    
    var counterNumberDisabled: some View {
        Text("\(counter.counter)")
            .font(.system(size: fontSize, weight: .light, design: .rounded))
            .foregroundColor(Color("disabled"))
            .padding(.bottom, 50)
            .padding(.horizontal)
    }
    
    var counterNumberEnabled: some View {
        Text("\(counter.counter)")
            .font(.system(size: fontSize, weight: .light, design: .rounded))
            
            .padding(.horizontal)
            .minimumScaleFactor(0.01)
            .lineLimit(1)
    }
    
    var body: some View {
        VStack {
            HStack {
                settingsButton
                Spacer()
                resetButton
            }
            Spacer()
            if counter.counter == 0 {
                counterNumberDisabled
            } else if counter.counter == counter.visitorLimit && counter.areVisitorsLimited {
                limitReached
                counterNumberEnabled
            } else if counter.counter > counter.visitorLimit && counter.areVisitorsLimited {
                tooManyVisitors
                counterNumberEnabled
            } else {
                counterNumberEnabled
            }
            Spacer()
            HStack(alignment: .center) {
                if counter.counter == 0 {
                    Button {
                        complexSuccess()
                        counter.counter -= 1
                    } label : {
                        CounterButton(action: "minus", buttonColor: Color("disabled"), buttonOpacity: 0.6)
                            .foregroundColor(Color("disable"))
                    }
                    .buttonStyle(CounterButtonStyle())
                    .disabled(true)
                } else {
                    Button {
                        complexSuccess()
                        counter.counter -= 1
                    } label: {
                        CounterButton(action: "minus", buttonColor: colorTheme, buttonOpacity: 1)
                    }
                    .buttonStyle(CounterButtonStyle())
                }
                Spacer()
                Button{
                    complexSuccess()
                    counter.counter += 1
                    print(counter.counter)
                } label: {
                    CounterButton(action: "plus", buttonColor: colorTheme, buttonOpacity: 1)
                }
                .buttonStyle(CounterButtonStyle())
                
                
            }
            .padding(.bottom, -10)
        }.padding(.horizontal)
        .onAppear(perform: {
            prepareHaptics()
        })
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(counter: counter, color: Color.mainTheme)
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(counter: Counter())
    }
}


