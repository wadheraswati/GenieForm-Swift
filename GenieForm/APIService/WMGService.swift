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
    func GETAPI(url : String, completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
    func POSTAPI(url : String, parameters : [String : AnyObject], completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
}

open class WMGService : UIViewController, WMGServiceProtocol {
    
    var token : String = ""
    
    @objc open func setToken(_ token : String) {
        self.token = token
    }
    
    func appendToken(_ url : String) -> String {
        let str = String.init(format: "%@&token=%@", url, "5acf4845ea4db5.37603490")
        return str
    }
    
    func GETAPI(url : String, completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
    {
        let request = Alamofire.request(appendToken(url),
                                        method: .get,
                                        parameters: nil)
        print("GET API Called - \(appendToken(url))")
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
    }
    
    func POSTAPI(url : String, parameters : [String : AnyObject], completion : @escaping (_ success : Bool, _ response : Result<Any>) -> ())
    {
        let request = Alamofire.request(appendToken(url), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        print("POST API Called - \(appendToken(url))")
        request.validate().responseJSON {response in
            //            print(response.response)
            //            print(response.error)
            //            print(response.result)
            //            print(response.result.value)
            //            print(response.result.error)
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
    }
}

