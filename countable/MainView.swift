//
//  MainView.swift
//  countable
//
//  Created by Rui Silva on 06/03/2021.
//

import SwiftUI
import CoreHaptics

struct MainView: View {
    
    @AppStorage("counter") var counter: Int = 0
    
    @State private var engine: CHHapticEngine?
    
    @State private var fontSize: CGFloat = 170
    
    var resetButton: some View {
        Text("Reset")
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(Color("Tint"))
            .frame(width: 90, height: 46)
            .background(Color("Tint").opacity(0.1))
            .cornerRadius(40)
    }
    
    var counterNumberDisabled: some View {
        Text("\(counter)")
            .font(.system(size: fontSize, weight: .light, design: .rounded))
            .foregroundColor(Color("disabled"))
            .padding(.bottom, 50)
            .padding(.horizontal)
    }
    
    var counterNumberEnabled: some View {
        Text("\(counter)")
            .font(.system(size: fontSize, weight: .light, design: .rounded))
            .padding(.bottom, 50)
            .padding(.horizontal)
            .minimumScaleFactor(0.01)
            .lineLimit(1)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    counter = 0
                    complexSuccess()
                } label: {
                    resetButton
                }
                .buttonStyle(CounterButtonStyle())
                .padding(.top, 5)
            }
            Spacer()
            if counter == 0 {
                counterNumberDisabled
            } else {
                counterNumberEnabled
            }
            Spacer()
            HStack(alignment: .center) {
                if counter == 0 {
                    Button {
                        complexSuccess()
                        counter -= 1
                    } label : {
                        CounterButton(action: "minus", buttonColor: "disabled", buttonOpacity: 0.6)
                            .foregroundColor(Color("disable"))
                    }
                    .buttonStyle(CounterButtonStyle())
                    .disabled(true)
                } else {
                    Button {
                        complexSuccess()
                        counter -= 1
                    } label: {
                        CounterButton(action: "minus", buttonColor: "Tint", buttonOpacity: 1)
                    }
                    .buttonStyle(CounterButtonStyle())
                }
                Spacer()
                Button{
                    complexSuccess()
                    counter += 1
                } label: {
                    CounterButton(action: "plus", buttonColor: "Tint", buttonOpacity: 1)
                }
                .buttonStyle(CounterButtonStyle())
                
            }
            .padding(.bottom, -10)
            
        }.padding(.horizontal)
        .onAppear(perform: {
            prepareHaptics()
        })
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
        MainView()
    }
}

struct CounterButton: View {
    
    var action: String
    var buttonColor: String
    var buttonOpacity: Double 
    var isPressed = true
  
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: buttonWidth(), height: buttonWidth())
                .foregroundColor(Color(buttonColor))
                .cornerRadius(10)
            Image(systemName: action)
                .font(.system(size: 42, weight: .regular, design: .rounded))
                .foregroundColor(.white)
        }
        .opacity(buttonOpacity)
        .padding(.bottom)
    }
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width) / 2.3
    }
}

struct CounterButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
//            .animation(.easeIn(duration: 0.3))
            .animation(.easeOut(duration: 0.2))
            
    }
}


