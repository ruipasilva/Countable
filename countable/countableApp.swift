//
//  countableApp.swift
//  countable
//
//  Created by Rui Silva on 06/03/2021.
//

import SwiftUI

@main
struct countableApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(Color("Tint"))
                .onAppear(perform: {
                    
                })
        }
    }
}
