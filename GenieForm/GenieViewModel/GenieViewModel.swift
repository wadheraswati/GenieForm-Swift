//
//  GenieViewModel.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class GenieViewModel {
    let apiService : WMGServiceProtocol = WMGService()
    
    var Fields : [WMGForm] = [WMGForm]()
    
    func getFormData(completion : @escaping (_ success : Bool) -> ()) {
        apiService.GETAPI(url: "form/genie?category_slug=wedding-photographers&city_slug=delhi-ncr", completion: {(success, result) in
            if(success) {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSArray
                for form in data {
                    do {
                        let formData = try JSONSerialization.data(withJSONObject: form, options: .prettyPrinted)
                        let formObject = try JSONDecoder().decode(WMGForm.self, from: formData)
                        self.Fields.append(formObject)
                        print(self.Fields)
                    }
                    catch {
                        print("json error: \(error.localizedDescription)")
                    }
                }
            }
            completion(success)
        })
    }
    
    func postFormData(_ params : [String : AnyObject], completion : @escaping (_ success : Bool) -> ()) {
        apiService.POSTAPI(url : "booking-lead/add?version=1.1&token=5aaf67d3973bf4.63432396&city_slug=delhi-ncr&category_slug=wedding-photographers", parameters: params, completion : {(success, result) in
            if(success) {
                
            }
            completion(success)
        })
    }
}
