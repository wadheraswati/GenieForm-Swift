//
//  GenieFormController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import M13Checkbox

class GenieFormController: UIViewController, UITextFieldDelegate, FormSelectionListDelegate {
    

    let cellIdentifier : String = "formCell"
    let viewModel : GenieViewModel = {
        return GenieViewModel()
    }()
    
    var apiParams : [String : AnyObject] = [:]
    
    var formScroll : UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "WMG Genie"
        initAPIData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - INIT Methods -
    func initView() {
        
        let submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("SUBMIT", for: UIControlState.normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.backgroundColor = AppColor.primaryRedColor
        submitBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(submitBtn)
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
        formScroll = UIScrollView(frame: CGRect(x: 0, y:y + 10, width: self.view.bounds.size.width, height: self.view.bounds.size.height - y - 40))
        self.view.addSubview(formScroll)
    }
    
    func initAPIData() {
        viewModel.getFormData(completion: {(success) in
            if(self.viewModel.Fields.count > 0) {
                self.initView()
                self.createFormUI()
            }
        })
        
    }
    
    // MARK: - Keyboard Notifications -
    @objc func keyboardWillShow(_ notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                formScroll.frame.size.height -= keyboardSize.height
            }
        }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            formScroll.frame.size.height += keyboardSize.height
        }
    }
    
    //MARK: - UITextFieldDelegateMethods -
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let formObj = self.viewModel.Fields[textField.tag - 1]
        var allow = true
        switch formObj.type {
        case .DatePicker, .TimePicker, .DateTimePicker, .MultiSelect, .SingleSelect:
            allow = false
        default:
            allow = true
        }
        
        switch formObj.type {
        case .DatePicker:
                let view = textField.superview as? FormDatepicker
                view?.showDatePickerInView(self.view)
        case .MultiSelect, .SingleSelect:
                let view = textField.superview as? FormSelectionList
                view?.showSelectionView(self.view)
        default:
            print("do nothing")
        }
        
        return allow
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    
    //MARK: - Validation Methods -

    func validate() ->Bool{
        var tag = 0
        for field in viewModel.Fields {
            tag += 1
            let textField : UITextField = formScroll.viewWithTag(tag) as! UITextField
            if(field.required == 1) {
                if textField.text?.count == 0 {
                    highlightTextField(textField)
                    return false
                }
                if(field.validation != nil) {
                    if !checkFieldForValidations(textField, field.validation!) {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    func checkFieldForValidations(_ textField : UITextField, _ validations : [Validation]) -> Bool {
        
        for validation in validations {
            if(validation.reg_ex != nil) {
                do {
                    let pass = try validateRegex(validation.reg_ex!, textField)
                    if !pass {
                        highlightTextField(textField)
                        self.present(Helper.showAlertWithMessage(validation.error, _title: "WMG Genie", options: ["Okay"]), animated: true, completion: nil)
                        return false
                    }
                } catch {
                    print("catched error")
                    return true
                }
            }
        }
        return true
    }
    
    func highlightTextField(_ textField : UITextField) {
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            textField.backgroundColor = AppColor.validationErrorColor
        }, completion: { (finished) -> Void in
            // ....
            UIView.animate(withDuration: 0.15, delay: 1.0, options: .curveEaseOut, animations: {() -> Void in
                textField.backgroundColor = AppColor.invisibleLightColor
            }, completion: nil)
        })
    }
    
    func validateRegex(_ regex : String, _ textField : UITextField) throws -> Bool {
        _ = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: textField.text)
    }
    
    //MARK: - Actions -
    
    @objc func submitBtnClicked() {
        
        if validate() {
            setParams()
            viewModel.postFormData(apiParams, completion: {(success) in
                
            })
            print("success")
        } else {
            print("failure")
        }
        
        
    }
    
    func setParams() {
        var tag = 0
        for field in viewModel.Fields {
            tag += 1
            let textField = formScroll.viewWithTag(tag) as! UITextField
            switch field.type {
            case .TextField, .MobileNumber, .Email, .DatePicker, .TimePicker, .DateTimePicker:
                apiParams[field.name] = textField.text as AnyObject
            default:
                print("default")
            }
        }
    }
    
    // MARK: - FormSelectionListDelegate Methods -
    func completedSelection(_ values: [Options], _ textField : UITextField) {
        //print("selected options - \(values)")
        var index = 0
        for option in values{
            let key : String =  String.init(format: "%@[%d]", viewModel.Fields[textField.tag - 1].name, index)
            apiParams[key] = option.name as AnyObject
            index += 1
        }
    }
    
    func selectedValue(_ textField : UITextField) {
        let field : WMGForm = viewModel.Fields[textField.tag - 1]
        for value in field.options! {
            if value.display_name == textField.text {
                apiParams[field.name] = value.name as AnyObject
            }
        }
    }
    
    // MARK - UI Methods -
    func createFormUI() {
        
        var y : CGFloat = 0.0
        let width : CGFloat = self.view.bounds.size.width
        let height : CGFloat = 60.0
        var tag : Int = 0
        for form in viewModel.Fields {
            tag += 1
            switch form.type {
            case .TextField:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormTextField = FormTextField(frame: fieldFrame)
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                currentTF.fieldTF.titleLabel.text = currentTF.fieldTF.title?.lowercased()
                formScroll.addSubview(currentTF)
            case .Email:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormEmail = FormEmail(frame: fieldFrame)
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                formScroll.addSubview(currentTF)
            case .MobileNumber:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormMobileNumber = FormMobileNumber(frame: fieldFrame)
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                formScroll.addSubview(currentTF)
            case .DatePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .date
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                formScroll.addSubview(currentTF)
            case .TimePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .time
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                formScroll.addSubview(currentTF)
            case .DateTimePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .dateAndTime
                currentTF.fieldTF.delegate = self
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                formScroll.addSubview(currentTF)
            case .SingleSelect:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormSelectionList = FormSelectionList(frame: fieldFrame)
                currentTF.multiSelect = false
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.delegate = self
                currentTF.values = form.options!
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                currentTF.delegate = self
                formScroll.addSubview(currentTF)
            case .MultiSelect:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormSelectionList = FormSelectionList(frame: fieldFrame)
                currentTF.multiSelect = true
                currentTF.fieldTF.tag = tag
                currentTF.fieldTF.delegate = self
                currentTF.values = form.options!
                currentTF.fieldTF.placeholder = form.display_name
                currentTF.fieldTF.title = form.display_name
                currentTF.delegate = self
                formScroll.addSubview(currentTF)
            default:
                print("add nothing")
            }
            y = (formScroll.subviews.last?.frame.size.height)! + y + 10
        }
        formScroll.contentSize = CGSize(width: formScroll.contentSize.width, height: y)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

