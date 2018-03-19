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
    
    func getFormData() {
        apiService.fetchGenieForm(url: "form/genie?category_slug=wedding-photographers&city_slug=delhi-ncr", completion: {(success, result) in
            if(success) {
                if let result = result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
            }
        })
    }
}
