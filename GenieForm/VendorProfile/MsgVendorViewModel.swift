//
//  MsgVenueViewModel.swift
//  GenieForm
//
//  Created by Swati Wadhera on 27/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class MsgVendorViewModel {
    
    let apiService : WMGServiceProtocol = WMGService()

    var profile = Profile()
    
    func messageVendor(_ params : [String : AnyObject], completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = APIList.messageVendor
        var apiParams : [String : AnyObject] = [:]
        
        apiParams["wedding_id"] = "" as AnyObject
        apiParams["vendor_id"] = profile.id as AnyObject
        apiParams.merge(params, uniquingKeysWith: { (first, _) in first })
        
        apiService.POSTAPI(url: apiStr, parameters: apiParams, completion: {(success, result)
            in
            if(success) {
                print(result.value!)
                let response = result.value as! NSDictionary
                if let data = response.value(forKey: "data") {
                    self.profile.inbox_thread_id = (data as! NSDictionary).value(forKey: "inbox_thread_id") as? String
                }
            }
            completion(success)
        })
    }
    
    func messageVenue(_ requirement : String, completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.messageVenue, profile.id)
        var apiParams : [String : AnyObject] = [:]
        
        apiParams["status"] = "8" as AnyObject
        apiParams["vendor_id"] = profile.id as AnyObject
        apiParams["requirement_json"] = "{\"requirement\":{\(requirement)}" as AnyObject
        
        apiService.POSTAPI(url: apiStr, parameters: apiParams, completion: {(success, result) in
            if(success) {
                print(result.value!)
                let response = result.value as! NSDictionary
                if let data = response.value(forKey: "data") {
                    self.profile.inbox_thread_id = data as? String
                }
            }
            completion(success)
        })
    }
    
    func updateMessageVenue(_ requirement : String, completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.messageVenue, profile.id)
        var apiParams : [String : AnyObject] = [:]
        
        apiParams["status"] = "1" as AnyObject
        apiParams["type"] = "1" as AnyObject
        apiParams["vendor_id"] = profile.id as AnyObject
        apiParams["requirement_json"] = "{\"requirement\":{\(requirement)}}" as AnyObject
        apiParams["booking_lead_id"] = self.profile.inbox_thread_id as AnyObject

        apiService.POSTAPI(url: apiStr, parameters: apiParams, completion: {(success, result) in
            if(success) {
                print(result.value!)
                let response = result.value as! NSDictionary
                if let data = response.value(forKey: "data") {
                    self.profile.inbox_thread_id = data as? String
                }
            }
            completion(success)
        })
    }
    
}
