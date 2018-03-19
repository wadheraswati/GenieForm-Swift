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
}
