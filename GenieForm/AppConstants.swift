//
//  AppConstants.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let primaryRedColor : UIColor  = UIColor(rgb : 0x673ab7)
    static let primaryCreamColor : UIColor  = UIColor(rgb : 0x673ab7)
    static let primaryGreenColor : UIColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    static let primaryBlackColor = UIColor.black
    
    static let secondaryWhiteColor : UIColor = UIColor(rgb : 0xF1F1F1)
    static let secondaryBlackColor : UIColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 144.0/255.0)
    static let textFieldBorderColor : UIColor = AppConstants.secondaryBlackColor.withAlphaComponent(0.3)
}
