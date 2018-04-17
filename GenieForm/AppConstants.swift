//
//  AppColor.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation
import UIKit

struct AppColor {
    static let primaryRedColor = UIColor(rgb : 0x673ab7)
    static let primaryCreamColor = UIColor(red: 244.0/255.0, green: 235.0/255.0, blue: 202.0/255.0, alpha: 1.0)

    static let primaryGreenColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    
    static let primaryWhiteColor = UIColor.white//UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    static let primaryBlackColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    
    static let secondaryWhiteColor = UIColor(rgb : 0xF1F1F1)
    static let secondaryBlackColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 144.0/255.0)
    static let secondaryRedColor = UIColor(red: 192.0/255.0, green: 57.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    
    static let tertiaryBlackColor = UIColor(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    static let invisibleLightColor = UIColor(white: 1, alpha: 0.01)
    
    static let textFieldBorderColor = AppColor.secondaryBlackColor.withAlphaComponent(0.3)
    static let validationErrorColor = AppColor.secondaryRedColor.withAlphaComponent(0.25)
}

struct APIList {
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    
    static let getGenieForm = APIList.baseURL + "v1/form/genie?category_slug=%@&city_slug=%@"
    static let postGenieForm = APIList.baseURL + "v1/booking-lead/add?version=1.1&category_slug=%@&city_slug=%@"
    
    static let getVendorProfile = APIList.baseURL + "v2/vendor/%@?version=1.1&member=%d"
    static let getVendorReviews = APIList.baseURL + "v1/vendor/%@/reviews?version=1.1&member=%d"
}

struct AppFont {
    static let mainFont = "ProximaNova-Regular"
    static let lightFont = "ProximaNova-Light"
    static let mediumFont = "ProximaNova-SemiBold"
    static let heavyFont = "ProximaNova-Bold"
    static let googleFont = "googleicon"
}

struct AppMessage {
    static let genieSuccessMsg = "Thanks for providing the information. Our genie team will get back to you soon."
}
