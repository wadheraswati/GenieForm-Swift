//
//  ProfileViewModel.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class ProfileViewModel {
    let apiService : WMGServiceProtocol = WMGService()
    var vendorID : String = ""
    var isMember : Bool = false
    
    var profile = Profile()
    var portfolio = [Images]()
    var albums = AlbumsInfo()
    var videos = VideosInfo()
    var faq = [FAQ]()
    var priceFAQ = [FAQ]()
    var pricing = [Pricing]()
    
    
    func getVendorProfile(completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.getVendorProfile, vendorID, isMember ? 1 : 0)

        apiService.GETAPI(url: apiStr, completion: {(success, result) in
            if(success) {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSDictionary
                    do {
                        let profileData = try JSONSerialization.data(withJSONObject: data.value(forKey: "profile")!, options: .prettyPrinted)
                        self.profile = try JSONDecoder().decode(Profile.self, from: profileData)
                        print(self.profile)
                        
                        let images = data.value(forKey: "images") as! NSArray
                        for image in images {
                            let imageData = try JSONSerialization.data(withJSONObject: image, options: .prettyPrinted)
                            self.portfolio.append(try JSONDecoder().decode(Images.self, from: imageData))
                        }
                        print(self.portfolio)

                        let albumsData = try JSONSerialization.data(withJSONObject: data.value(forKey: "albums")!, options: .prettyPrinted)
                        self.albums = try JSONDecoder().decode(AlbumsInfo.self, from: albumsData)
                        print(self.albums)
                        
                        let videosData = try JSONSerialization.data(withJSONObject: data.value(forKey: "videos")!, options: .prettyPrinted)
                        self.videos = try JSONDecoder().decode(VideosInfo.self, from: videosData)
                        print(self.videos)
                        
                        let faqs = data.value(forKey: "faq") as! NSArray
                        for faq in faqs {
                            let faqData = try JSONSerialization.data(withJSONObject: faq, options: .prettyPrinted)
                            self.faq.append(try JSONDecoder().decode(FAQ.self, from: faqData))
                        }
                        print(self.faq)
                        
                        let priceFAQs = data.value(forKey: "price_faq") as! NSArray
                        for priceFAQ in priceFAQs {
                            let priceFAQData = try JSONSerialization.data(withJSONObject: priceFAQ, options: .prettyPrinted)
                            self.priceFAQ.append(try JSONDecoder().decode(FAQ.self, from: priceFAQData))
                        }
                        print(self.priceFAQ)
                        
                        let pricingArr = data.value(forKey: "pricing") as! NSArray
                        for price in pricingArr {
                            let pricingData = try JSONSerialization.data(withJSONObject: price, options: .prettyPrinted)
                            self.pricing.append(try JSONDecoder().decode(Pricing.self, from: pricingData))
                        }
                        print(self.pricing)
                    }
                    catch {
                        print("json error: \(error)")
                    }
            }
            completion(success)
        })
    }
}
