//
//  Color+Extensions.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 15/01/2021.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static var buttonUnselectedColor: UIColor {
        return UIColor(red: 252 / 255, green: 204 / 255, blue: 213 / 255)
    }
    
    static var buttonSelectedColor: UIColor {
        return UIColor(red: 249 / 255, green: 117 / 255, blue: 140 / 255)
    }
}
