//
//  CALayer+Extension.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import UIKit

extension CALayer {
    
    func applyWhiteShadow(cornerRadius: CGFloat = 15, shadowRadius: CGFloat = 10) {
        
        self.cornerRadius = cornerRadius
        self.borderColor = UIColor.white.cgColor
        self.borderWidth = 1.5
        self.backgroundColor = .none

        // drop shadow
        self.shadowColor = UIColor.white.cgColor
        self.shadowOpacity = 0.8
        self.shadowRadius = shadowRadius
        self.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
    }
}
