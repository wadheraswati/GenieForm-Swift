//
//  WMGService.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation
import Alamofire

protocol WMGServiceProtocol {
     func fetchGenieForm(url : String, completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
}

class WMGService : WMGServiceProtocol {
    
    let baseURL : String = "https://developmentwow.wedmegood.com/api/"
    /*
     func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
     ...
     completion("we finished!")
     }
 */
    func fetchGenieForm(url : String, completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
    {
        let apiURL = URL(string: baseURL + url)
        let request = Alamofire.request(apiURL!,
                                        method: .get,
                                        parameters: nil)
        request.validate().responseJSON {response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print(JSON)
            }
            if response.response?.statusCode == 200 {
                completion(true, response.result)
            }
            else {
                completion(false, response.result)
            }
            }
        
            
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
    }
}
