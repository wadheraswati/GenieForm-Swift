//
//  Helper.swift
//  GenieForm
//
//  Created by Swati Wadhera on 26/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class Helper {
    
    // static added so that this message can be called directly from any class otherwise it was showing like Helper.showAlertWithMessage(self : Helper)
    static func showAlertWithMessage(_ msg : String, _title : String, options : [String]) -> UIAlertController {
        let alert = UIAlertController.init(title: _title, message: msg, preferredStyle: .alert)
        for option in options {
            alert.addAction(UIAlertAction.init(title: option, style: .default, handler: nil))
        }

        return alert
    }
    
    static func share(_ shareStr : String, _ controller : UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: [shareStr], applicationActivities: nil)
        controller.present(activityViewController, animated: true, completion: nil)
    }
    
    static func highlightTextField(_ textField : UITextField) {
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            textField.backgroundColor = AppColor.validationErrorColor
        }, completion: { (finished) -> Void in
            // ....
            UIView.animate(withDuration: 0.15, delay: 1.0, options: .curveEaseOut, animations: {() -> Void in
                textField.backgroundColor = AppColor.invisibleLightColor
            }, completion: nil)
        })
    }
}

class Validate {
    
    static func validateMobileNumber(_ text : String) throws -> Bool {
        if text.count == 0 { return false }
        
        let regex = "([+]?1+[-]?)?+([(]?+([0-9]{3})?+[)]?)?+[-]?+[0-9]{3}+[-]?+[0-9]{4}"
        _ = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: text)
    }
    
    static func validateLength(text : String, min : Int?, max : Int?) -> Bool {
       
        if text.count == 0 { return false }
        
        if let minLength = min {
            if text.count < minLength { return false }
        }
        
        if let maxLength = max {
            if text.count > maxLength { return false }
        }
        
        return true
    }
}
