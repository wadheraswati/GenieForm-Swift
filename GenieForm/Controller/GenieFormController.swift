//
//  GenieFormController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class GenieFormController: UIViewController {
    
    
    let cellIdentifier : String = "formCell"
    let viewModel : GenieViewModel = {
        return GenieViewModel()
    }()
    
    var formScroll : UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = AppConstants.secondaryWhiteColor
        self.navigationItem.title = "WMG Genie"
        initAPIData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
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
    
    
    func initAPIData() {
        viewModel.getFormData(completion: {(success) in
            if(self.viewModel.Fields.count > 0) {
                self.initView()
                self.createFormUI()
            }
        })
        
    }
    
    func initView() {
        
        let submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("SUBMIT", for: UIControlState.normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.backgroundColor = AppConstants.primaryRedColor
        submitBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(submitBtn)
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
        formScroll = UIScrollView(frame: CGRect(x: 0, y:y + 10, width: self.view.bounds.size.width, height: self.view.bounds.size.height - y - 40))
        self.view.addSubview(formScroll)
    }
    
    @objc func submitBtnClicked() {
        
    }
    
    func createFormUI() {
        
        var y : CGFloat = 0.0
        let width : CGFloat = self.view.bounds.size.width
        let height : CGFloat = 50.0
        for form in viewModel.Fields {
            
            switch form.type {
            case .TextField:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormTextField = FormTextField(frame: fieldFrame)
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .Email:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormEmail = FormEmail(frame: fieldFrame)
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .MobileNumber:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormMobileNumber = FormMobileNumber(frame: fieldFrame)
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .DatePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .date
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .TimePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .time
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .DateTimePicker:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormDatepicker = FormDatepicker(frame: fieldFrame)
                currentTF.datePicker.datePickerMode = .dateAndTime
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .SingleSelect:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormSelectionList = FormSelectionList(frame: fieldFrame)
                currentTF.multiSelect = false
                currentTF.values = form.options!
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            case .MultiSelect:
                let fieldFrame = CGRect(x: 0.0, y: y, width: width, height: height)
                let currentTF : FormSelectionList = FormSelectionList(frame: fieldFrame)
                currentTF.multiSelect = true
                currentTF.values = form.options!
                currentTF.fieldTF.placeholder = form.display_name
                formScroll.addSubview(currentTF)
            default:
                print("add nothing")
            }
            y = (formScroll.subviews.last?.frame.size.height)! + y
        }
        formScroll.contentSize = CGSize(width: formScroll.contentSize.width, height: y)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

