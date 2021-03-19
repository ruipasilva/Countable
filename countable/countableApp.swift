//
//  countableApp.swift
//  countable
//
//  Created by Rui Silva on 06/03/2021.
//

import SwiftUI

@main
struct countableApp: App {
    
    @StateObject var counter = Counter()
    
    @AppStorage("colorTheme") var colorTheme = Color.mainTheme
    
    var body: some Scene {
        WindowGroup {
            MainView(counter: counter)
                .accentColor(colorTheme)
        }
    }
}
