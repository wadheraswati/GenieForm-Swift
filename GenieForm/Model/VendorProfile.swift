//
//  VendorProfile.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

struct Profile : Codable {
    var id : Int
    var name : String
    var member_id : Int
    var category_id : Int
    var membership_id : Int
    var information : String
    var city : String
    //var love_count : Int
    var vendor_price : String
    var locality_name : String
    var phone : [String]
    var address : [Address]?
    var status : Int?
    var managed_by_wmg : Double?
    var shortlisted : Double?
    var inbox_thread_id : String?
    var send_query_default_message : String?
    var reviewInfo : ReviewsInfo?
    
    var contact_email : String?
    var vendor_price_subtext : String?
    var price_subtitle : String?
    var mask_number : String?
    
    var concierge_phone : String?
    var concierge_display_phone : String?
    // this init method is created to initialise an object in view model class of this struct
    init() {
        self.id = 0
        self.name = ""
        self.member_id = 0
        self.category_id = 0
        self.membership_id = 0
        self.information = ""
        self.city = ""
        //self.love_count = 0
        self.vendor_price = ""
        self.locality_name = ""
        self.phone = []
        self.status = 4
        self.shortlisted = 0
        
        self.contact_email = ""
        self.vendor_price_subtext = ""
        self.price_subtitle = ""
        self.mask_number = ""
        self.concierge_phone = ""
        self.concierge_display_phone = ""
    }
}

struct Address : Codable {
    var id : Int
    var latitude : String
    var longitude : String
    var display_address : String
    var is_primary : Bool
    var pincode : String
}

struct Images : Codable {
    var image_id : Int
    var image_width : Int
    var image_height : Int
    var image_url : String
}

struct AlbumsInfo : Codable {
    var albums_count : Double
    var images : [Album]
    
    init() {
        self.albums_count = 0
        self.images = []
    }
}

struct Album : Codable {
    var id : Double?
    var image_count : Int64
    var title : String
    var default_description : String?
    var description : String?
    var album_link : String
    var location : String?
    var cover_pic_url : String
    var section : String
}

struct VideosInfo : Codable {
    var videos_count : Int
    var video_array : [Video]
    
    init () {
        self.videos_count = 0
        self.video_array = []
    }
}

struct Video : Codable {
    var id : Int
    var video_link : String
    var video_title : String
    var video_image : String
}

struct FAQ : Codable {
    var id : String?
    var question : String
    var answer : String
    var highlight_text : Double?
    var span : Int
    
    var unit : String?
    var show_inr : Int?
    var fade : Int?
}

struct Pricing : Codable {
    var price : String
    var label : String?
    var unit : String
    var show_inr : Int
    var icon : String?
}


struct Flags : Codable {
    var status : Double?
    var mask_number_enabled : Double?
    var show_best_deal : Double? = 0
    var wmg_price_available : Double?
    var venue_send_enquiry : Double?
    
    init() {
        self.status = 4 //active status
        self.mask_number_enabled = 0
        self.show_best_deal = 0
        self.wmg_price_available = 0
        self.venue_send_enquiry = 0
    }
    
}

