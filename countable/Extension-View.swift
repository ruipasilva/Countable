//
//  Extension-View.swift
//  countable
//
//  Created by Rui Silva on 21/03/2021.
//

import Foundation
import SwiftUI


extension View {
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 0.5), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: true)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
