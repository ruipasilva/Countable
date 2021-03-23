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
    
    var body: some Scene {
        WindowGroup {
            MainView(counter: counter)
                .accentColor(Color("MainTheme"))
        }
    }
}
