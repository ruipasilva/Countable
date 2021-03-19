//
//  Color-Extension.swift
//  countable
//
//  Created by Rui Silva on 11/03/2021.
//

import Foundation
import SwiftUI
import UIKit

extension Color: RawRepresentable {
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondaryGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    
    static let systemBlue = Color(UIColor.systemBlue)
    static let systemGreen = Color(UIColor.systemGreen)
    static let systemIndigo = Color(UIColor.systemIndigo)
    static let systemOrange = Color(UIColor.systemOrange)
    static let systemPink = Color(UIColor.systemPink)
    static let systemPurple = Color(UIColor.systemPurple)
    static let systemRed = Color(UIColor.systemRed)
    static let systemTeal = Color(UIColor.systemTeal)
    static let systemYellow = Color(UIColor.systemYellow)
    static let mainTheme = Color("Tint")
    
    public init?(rawValue: String) {
        
        guard let data = Data(base64Encoded: rawValue) else{
            self = .black
            return
        }
        do{
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        }catch{
            self = .black
        }
    }
    public var rawValue: String {
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
            
        }catch{
            
            return ""
        }
    }
}

