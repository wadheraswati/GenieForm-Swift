//
//  WMGForm.swift
//  WMGForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation

public enum FieldType : Int, Codable {
    case TextField = 1
    case Email = 2
    case MobileNumber = 3
    case DatePicker = 4
    case TimePicker = 5
    case DateTimePicker = 6
    case Checkbox = 7
    case RadioButton = 8
    case SingleSelect = 9
    case MultiSelect = 10
    case FilePicker = 11
    case Range = 12
    case Toggle = 13
    case TextBox = 14
    case Dropdown = 15
    case Label = 16
}

struct WMGForm : Codable {
    var id : Int
    var name : String
    var display_name : String
    var type : FieldType
    var subtype : FieldType
    var placeholder : String?
    var options : [Options]?
    var required : Int
    var validation : [Validation]?
    var isValid : Bool? = false
    
//    enum CodingKeys: String, CodingKey
//    {
//        case id
//        case name
//        case displayName = "display_name"
//        case type
//        case subtype
//        case placeholder
//        case options
//        case required
//        case validation
//    }
    
//    enum OptionKeys : String, CodingKey {
//        case id
//        case display_name
//        case name
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int.self, forKey: .id)
//        name = try values.decode(String.self, forKey: .name)
//        displayName = try values.decode(String.self, forKey: .name)
//        type = try values.decode(FieldType.self, forKey: .name)
//        subtype = try values.decode(FieldType.self, forKey: .name)
//        placeholder = try values.decode(String.self, forKey: .name)
//        let optionObj = try values.nestedContainer(keyedBy: OptionKeys.self, forKey: .options)
//
//        options = try values.nestedUnkeyedContainer(forKey: <#T##WMGForm.CodingKeys#>)(Options.self, forKey: .name)
//        required = try values.decode(Bool.self, forKey: .name)
//        validation = try values.decode(String.self, forKey: .name)
//    }
}

struct Validation : Codable {
    var id : Int
    var error : String
    var reg_ex : String
    var min_length : Int?
    var max_length : Int?
    var min_value : Int?
    var max_value : Int?
    var step_size : Int?
    var text : Int?
}

struct Options : Codable {
    var id : Int
    var display_name : String
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case display_name
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = (try values.decodeIfPresent(Int.self, forKey: .id))!
        } catch DecodingError.typeMismatch {
            if let string = try values.decodeIfPresent(String.self, forKey: .id) {
                id = Int(string)!
            } else {
                id = 0
            }
        }
        display_name = try values.decode(String.self, forKey: .display_name)
        name = try values.decode(String.self, forKey: .name)
    }
}









