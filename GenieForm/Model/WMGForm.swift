//
//  WMGForm.swift
//  WMGForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import Foundation

enum FormType : String, Codable {
    case TextField
    case Email
    case MobileNumber
    case DatePicker
    case TimePicker
    case DateTimePicker
    case Checkbox
    case RadioButton
    case SingleSelect
    case MultiSelect
    case FilePicker
    case Range
    case TextBox
    case Dropdown
    case Label
}

struct WMGForm : Codable {
    let id : Int
    let name : String
    let displayName : String
    let type : FormType
    let subtype : Int
    let placeholder : String
    let options : [Options]
    let required : Bool
    let validation : [Validation]
    let isValid :Bool
}

struct Validation : Codable {
    let error : String
    let min_length : Int
    let max_length : Int
    let min_value : Int
    let max_value : Int
    let step_size : Int
    let text : Int
}

struct Options : Codable {
    let id : Int
    let display_name : String
    let name : String
}









