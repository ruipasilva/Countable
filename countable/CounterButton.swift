//
//  CounterButtonStyle.swift
//  countable
//
//  Created by Rui Silva on 18/03/2021.
//

import Foundation
import SwiftUI

struct CounterButton: View {
    
    var action: String
    var buttonColor: Color
    var buttonOpacity: Double
    var isPressed = true
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: buttonWidth(), height: buttonWidth())
                .foregroundColor(buttonColor)
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
            .animation(.easeOut(duration: 0.2))
        
    }
}
