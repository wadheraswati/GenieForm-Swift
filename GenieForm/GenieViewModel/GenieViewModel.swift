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
    
    private var Fields : [WMGForm] = [WMGForm]()
    
    func getFormData() {
        apiService.fetchGenieForm(url: "form/genie?category_slug=wedding-photographers&city_slug=delhi-ncr", completion: {(success, result) in
            if(success) {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSArray
                for form in data {
                    do {
                        let formData = try JSONSerialization.data(withJSONObject: form, options: .prettyPrinted)
//                        let value = try JSONSerialization.jsonObject(with: formData, options: .allowFragments)
                        let formObject = try JSONDecoder().decode(WMGForm.self, from: formData)
                        self.Fields.append(formObject)
                        print(self.Fields)
                    }
                    catch {
                        print("json error: \(error.localizedDescription)")
                    }
                }
            }
        })
    }
}
