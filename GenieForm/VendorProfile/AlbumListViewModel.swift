//
//  AlbumListViewModel.swift
//  GenieForm
//
//  Created by Swati Wadhera on 25/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class AlbumListViewModel {

    let apiService : WMGServiceProtocol = WMGService()
    
    var albumList = [AlbumList]()
    
    var profile = AlbumProfile()
    var memberID : Int = 0
    var shareURL : String!
    
    func fetchAlbums(completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.albumList, memberID)
        
        apiService.GETAPI(url: apiStr, completion: { (success, result) in
            if success {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSDictionary
                do {
                    if data.value(forKey: "albums") != nil {
                        let albumsArr = data.value(forKey: "albums") as! NSArray
                        for album in albumsArr {
                            let albumData = try JSONSerialization.data(withJSONObject: album, options: .prettyPrinted)
                            self.albumList.append(try JSONDecoder().decode(AlbumList.self, from: albumData))
                        }
                    }
                    
                    let profileData = try JSONSerialization.data(withJSONObject: data.value(forKey: "profile")!, options: .prettyPrinted)
                    self.profile = try JSONDecoder().decode(AlbumProfile.self, from: profileData)
                    print(self.profile)
                    
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
}


struct AlbumProfile : Codable {
    
    var name : String
    var category : String
    var base_city : String
    
    init() {
        self.name = ""
        self.category = ""
        self.base_city = ""
    }
}

struct AlbumList : Codable {
    var section : String
    var id : String
    var project_name : String
    var cover_pic_url : String
    var image_count : String
    var location : String?
}
