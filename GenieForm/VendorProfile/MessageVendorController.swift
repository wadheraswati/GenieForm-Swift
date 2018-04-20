//
//  MessageVendorDelegate.swift
//  GenieForm
//
//  Created by Swati Wadhera on 20/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class MessageVendorController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var containerScroll = UIScrollView()
    var submitBtn = UIButton()
    var profileVM = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Send Message"
        self.view.backgroundColor = AppColor.primaryWhiteColor

        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
        self.navigationController?.navigationBar.tintColor = AppColor.primaryBlackColor
        
        submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("Send Message", for: .normal)
        submitBtn.setTitleColor(AppColor.primaryWhiteColor, for: .normal)
        submitBtn.contentHorizontalAlignment = .center
        submitBtn.backgroundColor = AppColor.primaryRedColor
        submitBtn.titleLabel?.font = UIFont.init(name: AppFont.mediumFont, size: 16)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.addTarget(self, action: #selector(sendQuery), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        
        containerScroll = UIScrollView(frame: CGRect(x: 0, y: y, width: self.view.bounds.size.width, height: self.view.bounds.size.height - y - submitBtn.frame.size.height))
        containerScroll.clipsToBounds = true;
        self.view.addSubview(containerScroll)
        
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        
        var y = CGFloat(10)
        let x = CGFloat(10)
        let width = containerScroll.bounds.size.width - x*2
        let lbl = UILabel(frame: CGRect(x: x, y: y, width: width, height: 0))
        
        lbl.font = UIFont.init(name: AppFont.mainFont, size: 15)
        lbl.textColor = AppColor.primaryRedColor
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "Fill out the form with your details and the vendor will get in touch with you"
        lbl.sizeToFit()
        containerScroll.addSubview(lbl)
        
        y += lbl.bounds.size.height + 20
        
        let dateLbl = UILabel(frame: CGRect(x: x, y: y, width: width, height: 0))
        dateLbl.font = UIFont.init(name: AppFont.mediumFont, size: 14)
        dateLbl.textColor = AppColor.primaryBlackColor
        dateLbl.numberOfLines = 0
        dateLbl.textAlignment = .left
        dateLbl.lineBreakMode = .byWordWrapping
        dateLbl.text = "Event Date*"
        dateLbl.sizeToFit()
        containerScroll.addSubview(dateLbl)
        
        y += dateLbl.bounds.size.height + 5
        
        let dateTF : FormDatepicker = FormDatepicker(frame : CGRect(x: x, y: y, width: width, height: 50))
        dateTF.fieldTF.frame.origin.x = 0
        dateTF.fieldTF.frame.size.width = width
        dateTF.datePicker.datePickerMode = .date
        dateTF.fieldTF.delegate = self
        dateTF.fieldTF.tag = 100
        dateTF.fieldTF.backgroundColor = AppColor.secondaryWhiteColor
        dateTF.fieldTF.placeholder = "24 Aug, 2018"
        containerScroll.addSubview(dateTF)
        
        y += dateTF.frame.size.height + 10

        let msgLbl = UILabel(frame: CGRect(x: x, y: y, width: width, height: 0))
        msgLbl.font = UIFont.init(name: AppFont.mediumFont, size: 14)
        msgLbl.textColor = AppColor.primaryBlackColor
        msgLbl.numberOfLines = 0
        msgLbl.textAlignment = .left
        msgLbl.lineBreakMode = .byWordWrapping
        msgLbl.text = "Message (Min. 100 characters)*"
        msgLbl.sizeToFit()
        containerScroll.addSubview(msgLbl)
        
        y += msgLbl.bounds.size.height + 10
        
        let msgTV = UITextView(frame: CGRect(x: x, y: y, width: width, height: containerScroll.bounds.size.height - y - 10))
        msgTV.textColor = AppColor.primaryBlackColor
        msgTV.font = UIFont.init(name: AppFont.mainFont, size: 15)
        msgTV.textAlignment = .left
        msgTV.text = profileVM.profile.send_query_default_message!
        msgTV.delegate = self
        msgTV.tag = 101
        msgTV.autocorrectionType = .no
        msgTV.backgroundColor = AppColor.secondaryWhiteColor
        msgTV.layer.borderColor = AppColor.textFieldBorderColor.cgColor
        msgTV.layer.borderWidth = 1
        containerScroll.addSubview(msgTV)
        
        y += msgTV.frame.size.height + 10
        
        containerScroll.contentSize = CGSize(width: containerScroll.bounds.size.width, height: y)
    }
    
    // MARK: - Keyboard Notifications -
    @objc func keyboardWillShow(_ notification : NSNotification) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            containerScroll.frame.size.height -= keyboardSize.height
            submitBtn.frame.origin.y = containerScroll.frame.origin.y + containerScroll.frame.size.height
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            containerScroll.frame.size.height += keyboardSize.height
            submitBtn.frame.origin.y = containerScroll.frame.origin.y + containerScroll.frame.size.height
        }
    }
    
    //MARK: - UITextFieldDelegate Methods -
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let view = textField.superview as? FormDatepicker
        view?.showDatePickerInView(self.view)
        return false;
    }
    
    //MARK: - Action Methods -
    @objc func sendQuery() {
        if validate() {
            
            let dateTF = containerScroll.viewWithTag(100) as! UITextField
            let msgTV = containerScroll.viewWithTag(101) as! UITextView

            let params : [String : AnyObject] = ["function_date" : dateTF.text as AnyObject,            "requirements" : msgTV.text as AnyObject]
            
            profileVM.messageVendor(params, completion: {(success) in
                if success {
                    //TODO: Add success popup here
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func validate() -> Bool {
        
        var valid = true
        var errorMsg = ""
        
        let dateTF = containerScroll.viewWithTag(100) as! UITextField
        let msgTV = containerScroll.viewWithTag(101) as! UITextView

        if dateTF.text?.count == 0 {
            valid = false
            errorMsg = "Please mention your event date"
        } else if msgTV.text?.count == 0 {
            valid = false
            errorMsg = "Please mention your requirements"
        } else if (msgTV.text?.count)! < 100 {
            valid = false
            errorMsg = "Message should be of minimum 100 characters"
        }
        
        print(errorMsg)
        
        return valid
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
