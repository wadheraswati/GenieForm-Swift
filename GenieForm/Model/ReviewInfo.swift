//
//  ReviewInfo.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

struct ReviewsInfo : Codable {
    var vendor_id : String
    var name : String
    var vendor_rating : String
    var reviews_count : Int
    var is_reviewed : Int
    var last_review_update : Int64?
    var category_has_sticker : Int?
    
    init() {
        self.vendor_id = ""
        self.name = ""
        self.vendor_rating = ""
        self.reviews_count = 0
        self.is_reviewed = 0
        self.last_review_update = 1
        self.category_has_sticker = 0
    }
}

struct Reviews : Codable {
    var id : String
    var reviewer_name : String
    var reviewer_id : String?
    var review_description : String
    var star_rating : String
    var reviewTimestamp : Int64
    var status : String
    var user_image : String
    var share_link : String
    var reviewed_on_text : String
    var review_images : [ReviewImage]?
    var stickers : [Sticker]?
}

struct ReviewImage : Codable {
    var image_id : String
    var image_url : String
}

struct Sticker : Codable {
    var sticker_id : String
    var name : String
    var sticker_url : String
}
