//
//  UIColor+Extension.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import UIKit
import SwiftUI

extension UIColor {
    
    static let customRed1 = UIColor(red: 42/255, green: 8/255, blue: 7/255, alpha: 1)
    static let customRed2 = UIColor(red: 123/255, green: 54/255, blue: 34/255, alpha: 1)
    static let customRed3 = UIColor(red: 199/255, green: 43/255, blue: 50/255, alpha: 1)
    static let customYellow1 = UIColor(red: 184/255, green: 136/255, blue: 73/255, alpha: 1)
    static let customYellow2 = UIColor(red: 239/255, green: 191/255, blue: 65/255, alpha: 1)
    static let customOrange1 = UIColor(red: 187/255, green: 49/255, blue: 40/255, alpha: 1)
    static let customOrange2 = UIColor(red: 226/255, green: 106/255, blue: 51/255, alpha: 1)
    static let customBlue1 = UIColor(red: 38/255, green: 68/255, blue: 142/255, alpha: 1)
    static let customWhite1 = UIColor(red: 235/255, green: 229/255, blue: 206/255, alpha: 1)
}

extension UIColor {
    
    public convenience init?(hex: String, alpha: Double = 1.0) {
        
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

extension Color {
    
    static let customRed1 = Color(red: 42/255, green: 8/255, blue: 7/255)
    static let customRed2 = Color(red: 123/255, green: 54/255, blue: 34/255)
    static let customYellow1 = Color(red: 184/255, green: 136/255, blue: 73/255)
    static let customYellow2 = Color(red: 239/255, green: 191/255, blue: 65/255)
    static let customOrange1 = Color(red: 187/255, green: 49/255, blue: 40/255)
    static let customOrange2 = Color(red: 226/255, green: 106/255, blue: 51/255)
    static let customBlue1 = Color(red: 38/255, green: 68/255, blue: 142/255)
    static let customWhite1 = Color(red: 235/255, green: 229/255, blue: 206/255)
}
