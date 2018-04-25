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
    
    var profile = Profile()
    var portfolio = [Images]()
    var albums = AlbumsInfo()
    var videos = VideosInfo()
    var faq = [FAQ]()
    var priceFAQ = [FAQ]()
    var pricing = [Pricing]()
    var flags = Flags()
    var reviews = [Reviews]()
    var reviewInfo = ReviewsInfo()
    var areas = [Area]()
    
    var shareURL : String!

    func getVendorProfile(vendorID : String, isMember : Bool, completion : @escaping (_ success : Bool) -> ()) {
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
                        
                        if (data.value(forKey: "videos") != nil) {
                            let videosData = try JSONSerialization.data(withJSONObject: data.value(forKey: "videos")!, options: .prettyPrinted)
                            self.videos = try JSONDecoder().decode(VideosInfo.self, from: videosData)
                            print(self.videos)
                        }
                        
                        let faqs = data.value(forKey: "faq") as! NSArray
                        for faq in faqs {
                            let faqData = try JSONSerialization.data(withJSONObject: faq, options: .prettyPrinted)
                            self.faq.append(try JSONDecoder().decode(FAQ.self, from: faqData))
                        }
                        print(self.faq)
                        
                        if (data.value(forKey: "price_faq") != nil) {
                            let priceFAQs = data.value(forKey: "price_faq") as! NSArray
                            for priceFAQ in priceFAQs {
                                let priceFAQData = try JSONSerialization.data(withJSONObject: priceFAQ, options: .prettyPrinted)
                                self.priceFAQ.append(try JSONDecoder().decode(FAQ.self, from: priceFAQData))
                            }
                            print(self.priceFAQ)
                        }
                        
                        let pricingArr = data.value(forKey: "pricing") as! NSArray
                        for price in pricingArr {
                            let pricingData = try JSONSerialization.data(withJSONObject: price, options: .prettyPrinted)
                            self.pricing.append(try JSONDecoder().decode(Pricing.self, from: pricingData))
                        }
                        print(self.pricing)
                        
                        if (data.value(forKey: "banquet") != nil) {
                            let areaArr = data.value(forKey: "banquet") as! NSArray
                            for area in areaArr {
                                let areaData = try JSONSerialization.data(withJSONObject: area, options: .prettyPrinted)
                                self.areas.append(try JSONDecoder().decode(Area.self, from: areaData))
                            }
                        }
                        print(self.areas)
                        
                        let flagsData = try JSONSerialization.data(withJSONObject: data.value(forKey: "flags")!, options: .prettyPrinted)
                        self.flags = try JSONDecoder().decode(Flags.self, from: flagsData)
                        print(self.flags)
                        
                        if (data.value(forKey: "concierge_phone") != nil) {
                            self.profile.concierge_phone = (data.value(forKey: "concierge_phone") as! String)
                        }
                        
                        if (data.value(forKey: "concierge_display_phone") != nil) {
                            self.profile.concierge_display_phone = (data.value(forKey: "concierge_display_phone") as! String)
                        }
                        
                        if data.value(forKey: "seoData") != nil {
                            let seoData = data.value(forKey: "seoData") as! NSDictionary
                            self.shareURL = seoData.value(forKey: "canonical_url") as! String
                        }

                    }
                    catch {
                        print("json error: \(error)")
                    }
            }
            completion(success)
        })
    }
    
    func getVendorReviewInfo(isMember : Bool, completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.getVendorReviews, profile.id, isMember ? 1 : 0)
        
        apiService.GETAPI(url: apiStr, completion: {(success, result) in
            if(success) {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSDictionary
                do {
                    
                    let reviewInfoData = try JSONSerialization.data(withJSONObject: data.value(forKey: "profile")!, options: .prettyPrinted)
                    self.reviewInfo = try JSONDecoder().decode(ReviewsInfo.self, from: reviewInfoData)
                    print(self.reviewInfo)
                    
                    if(data.value(forKey: "reviews") != nil) {
                        let reviews = data.value(forKey: "reviews") as! NSArray
                        for review in reviews {
                            let reviewData = try JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
                            self.reviews.append(try JSONDecoder().decode(Reviews.self, from: reviewData))
                        }
                    }
                    
                    print(self.reviews)
                    self.profile.reviewInfo = self.reviewInfo
                }
                catch {
                    print("json error: \(error)")
                }
            }
            completion(success)
        })
    }
    
    func shortlistVendor(completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = APIList.shortlistVendor
        var apiParams : [String : AnyObject] = [:]
        
        apiParams["wedding_id"] = "" as AnyObject
        apiParams["vendor_id"] = profile.id as AnyObject

        apiService.POSTAPI(url: apiStr, parameters: apiParams, completion : {(success, result) in
            if(success) {
                let apiResponse = result.value as! NSDictionary
                self.profile.shortlisted = apiResponse.value(forKey: "data") as? Double
            }
            completion(success)
        })
    }
    
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
        apiParams["requirement_json"] = requirement as AnyObject
        
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
}


