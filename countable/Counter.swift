//
//  Counter.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import Foundation
import SwiftUI

class Counter: ObservableObject {
    
    static let colors: [Color] = [Color.systemBlue, Color.systemGreen, Color.systemIndigo, Color.systemOrange, Color.systemPink, Color.systemPurple, Color.systemRed, Color.systemTeal, Color.systemYellow, Color.mainTheme]

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
    
    init() {
        counter = UserDefaults.standard.object(forKey: "counter") as? Int ?? 0
        visitorLimit = UserDefaults.standard.object(forKey: "visitorLimit") as? Int ?? 0
        areVisitorsLimited = UserDefaults.standard.object(forKey: "areVisitorsLimited") as! Bool
        
    }
    
    
}





