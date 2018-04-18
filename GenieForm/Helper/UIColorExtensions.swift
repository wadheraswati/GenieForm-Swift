//
//  UIColorExtensions.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /*
     if(rating <=1) return UIColorFromRGB(0xcb202d);
     else if(rating <=2) return UIColorFromRGB(0xff7800);
     else if(rating <=3) return UIColorFromRGB(0xffba00);
     else if(rating <=4) return UIColorFromRGB(0x9acd32);
     else return UIColorFromRGB(0x5ba829);
 */
    convenience init(rating : String) {
        var ratingF = CGFloat(0)
        if let n = NumberFormatter().number(from: rating) {
            ratingF = CGFloat(truncating: n)
        }
        var colorUint : UInt = 0x5ba829
        if ratingF <= 1 { colorUint = 0xcb202d }
        else if ratingF <= 2 { colorUint = 0xff7800 }
        else if ratingF <= 3 { colorUint = 0xffba00 }
        else if ratingF <= 4 { colorUint = 0x9acd32 }
        else { colorUint = 0x5ba829 }
        self.init(rgb: colorUint)
    }
}


