//
//  NSMutableAttributedString+Extension.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import UIKit

extension NSMutableAttributedString {


    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont.boldSystemFont(ofSize: 15)]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 15)]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
