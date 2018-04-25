//
//  VenueInfo.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation

struct Menu : Codable {
    var id : Double
    var title : String
    var price_per_plate : Double
    var menu_type_id : Double
}

struct Area : Codable {
    var id : Double
    var title : String
    var indoor_outdoor : Double
    var fixed_capacity : Double
    var floating_capacity : Double
}

struct MenuFiles : Codable {
    var id : Int
    var filename : String
    var menu_url : String
    var ext : String
}
