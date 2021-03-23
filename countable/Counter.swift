//
//  Counter.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import Foundation
import SwiftUI

class Counter: ObservableObject {
    
    static let colors = ["Blue", "Green", "Indigo", "Orange", "Pink", "Purple", "Red", "Teal", "Yellow", "MainTheme"]

    @Published var counter: Int {
        didSet {
            UserDefaults.standard.set(counter, forKey: "counter")
        }
    }
    
    @Published var visitorLimit: Int {
        didSet {
            UserDefaults.standard.set(visitorLimit, forKey: "visitorLimit")
        }
    }
    
    @Published var areVisitorsLimited: Bool  {
        didSet {
            visitorLimit = 0
            UserDefaults.standard.set(areVisitorsLimited, forKey: "areVisitorsLimited")
        }
    }
    
    @Published var colorTheme = "MainTheme" {
        didSet {
            UserDefaults.standard.set(colorTheme, forKey: "colorTheme")
        }
    }
    init() {
        counter = UserDefaults.standard.object(forKey: "counter") as? Int ?? 0
        visitorLimit = UserDefaults.standard.object(forKey: "visitorLimit") as? Int ?? 0
        areVisitorsLimited = UserDefaults.standard.object(forKey: "areVisitorsLimited") as? Bool ?? false
        colorTheme = UserDefaults.standard.object(forKey: "colorTheme") as? String ?? "MainTheme"
    }
}





