//
//  WMGForm.swift
//  WMGForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation

enum FieldType : Int, Codable {
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
    
}

struct Validation : Codable {
    var error : String
    var min_length : Int
    var max_length : Int
    var min_value : Int
    var max_value : Int
    var step_size : Int
    var text : Int
}

struct Options : Codable {
    var id : Int
    var display_name : String
    var name : String
}









