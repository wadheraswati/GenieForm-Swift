//
//  VideoListViewModel.swift
//  GenieForm
//
//  Created by Swati Wadhera on 25/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class VideoListViewModel: NSObject {

    let apiService : WMGServiceProtocol = WMGService()

    var videoList = [VideoList]()
    var profile = VideoProfile()

    var memberID : Int = 0
    
    func fetchVideos(completion : @escaping (_ success : Bool) -> ()) {
        let apiStr = String.init(format: APIList.albumList, memberID)
        
        apiService.GETAPI(url: apiStr, completion: { (success, result) in
            if success {
                let apiResponse = result.value as! NSDictionary
                let data = apiResponse.value(forKey: "data") as! NSDictionary
                do {
                    if data.value(forKey: "videos") != nil {
                        let videosArr = data.value(forKey: "videos") as! NSArray
                        for video in videosArr {
                            let videoData = try JSONSerialization.data(withJSONObject: video, options: .prettyPrinted)
                            self.videoList.append(try JSONDecoder().decode(VideoList.self, from: videoData))
                        }
                    }
                    
                    let profileData = try JSONSerialization.data(withJSONObject: data.value(forKey: "profile")!, options: .prettyPrinted)
                    self.profile = try JSONDecoder().decode(VideoProfile.self, from: profileData)
                    print(self.profile)
                }
                catch {
                    print("json error: \(error)")
                }
            }
            completion(success)
        })
    }
}

struct VideoList : Codable {
    var id : String
    var video_link : String
    var video_title : String
    var video_duration : Double
    var video_image : String
}

struct VideoProfile : Codable {
    
    var name : String
    var category : String
    var base_city : String
    
    init() {
        self.name = ""
        self.category = ""
        self.base_city = ""
    }
}
