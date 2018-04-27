//
//  MessageVenueController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 23/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

public enum MenuType : String {
    case veg = "Veg Menu"
    case nonveg = "Non Veg Menu"
}

class MessageVenueController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, FormSelectionListDelegate {

    var submitBtn = UIButton()
    var tableView = UITableView()
    var viewModel = MsgVendorViewModel()
    
    var menuOptions = [Options(id: MenuType.veg.hashValue, display_name: MenuType.veg.rawValue, name: MenuType.veg.rawValue), Options(id: MenuType.nonveg.hashValue, display_name: MenuType.nonveg.rawValue, name: MenuType.nonveg.rawValue)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Send Message"
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
        
        submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("Check availability & prices", for: .normal)
        submitBtn.setTitleColor(AppColor.primaryWhiteColor, for: .normal)
        submitBtn.contentHorizontalAlignment = .center
        submitBtn.backgroundColor = AppColor.primaryRedColor
        submitBtn.titleLabel?.font = UIFont.init(name: AppFont.mediumFont, size: 16)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.addTarget(self, action: #selector(sendQuery), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        
        let headingLbl = UILabel(frame: CGRect(x: 10, y: y + 10, width: self.view.bounds.size.width - 20, height: 0))
        headingLbl.text = "Fill out the form with your details and the vendor will get in touch with you"
        headingLbl.textColor = AppColor.primaryRedColor
        headingLbl.textAlignment = .center
        headingLbl.font = UIFont.init(name: AppFont.mainFont, size: 15)
        headingLbl.numberOfLines = 0
        headingLbl.lineBreakMode = .byWordWrapping
        headingLbl.sizeToFit()
        headingLbl.center = CGPoint(x: self.view.bounds.size.width/2, y: headingLbl.center.y)
        self.view.addSubview(headingLbl)
        
        tableView = UITableView(frame: CGRect(x: 10, y: headingLbl.frame.origin.y + headingLbl.bounds.size.height + 20, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - submitBtn.frame.size.height - headingLbl.bounds.size.height - headingLbl.frame.origin.y - 40) , style: .plain)
        tableView.backgroundColor = AppColor.secondaryWhiteColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        // Do any additional setup after loading the view.
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.backgroundColor = AppColor.invisibleLightColor
        
        cell.selectionStyle = .none
        switch indexPath.row + 1 {
        case 1:
            var view = FormDatepicker()
            if cell.viewWithTag(indexPath.row + 1) == nil {
                view = FormDatepicker(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
                view.tag = (indexPath.row + 1)*100
                cell.addSubview(view)
            }
            view.fieldTF.tag = indexPath.row + 1
            view.datePicker.datePickerMode = .date
            view.fieldTF.placeholder = "Function Date*"
            view.fieldTF.delegate = self
            break
        case 2:
            var view = FormMobileNumber()
            if cell.viewWithTag(indexPath.row + 1) == nil {
                view = FormMobileNumber(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
                view.tag = (indexPath.row + 1)*100
                cell.addSubview(view)
            }
            view.fieldTF.tag = indexPath.row + 1
            view.fieldTF.placeholder = "Mobile number*"
            view.fieldTF.delegate = self
            break
        case 3:
            var view = FormTextField()
            if cell.viewWithTag(indexPath.row + 1) == nil {
                view = FormTextField(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
                view.tag = (indexPath.row + 1)*100
                cell.addSubview(view)
            }
            view.fieldTF.keyboardType = .numbersAndPunctuation
            view.fieldTF.tag = indexPath.row + 1
            view.fieldTF.placeholder = "No. of guests (minimum 50)"
            view.fieldTF.delegate = self
            break
        case 4:
            var view = FormTextField()
            if cell.viewWithTag(indexPath.row + 1) == nil {
                view = FormTextField(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
                view.tag = (indexPath.row + 1)*100
                cell.addSubview(view)
            }
            view.fieldTF.keyboardType = .numbersAndPunctuation
            view.fieldTF.tag = indexPath.row + 1
            view.fieldTF.placeholder = "No. of rooms required"
            view.fieldTF.delegate = self
            break
        case 5:
            var view = FormSelectionList()
            if cell.viewWithTag(indexPath.row + 1) == nil {
                view = FormSelectionList(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
                view.tag = (indexPath.row + 1)*100
                cell.addSubview(view)
            }
            view.fieldTF.tag = indexPath.row + 1
            view.values = menuOptions
            view.delegate = self
            view.fieldTF.placeholder = "Select Menu"
            view.multiSelect = true
            view.fieldTF.delegate = self
            break
        default:
            
            break
        }
    
        return cell
    }
    
    
    
    // MARK: - Keyboard Notifications -
    
    @objc func keyboardWillShow(_ notification : NSNotification) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame.size.height -= keyboardSize.height - 50
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame.size.height += keyboardSize.height - 50
        }
    }
    
    //MARK: - FormSelectionDelegate Methods -
    func completedSelection(_ values: [Options], _ textField: UITextField) {
        
    }
    
    func selectedValue(_ textField: UITextField) {
        
    }
    
    //MARK: - UITextFieldDelegateMethods -
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var allow = false
        switch textField.tag {
        case 1:
            let view = textField.superview as? FormDatepicker
            view?.showDatePickerInView(self.view)
            break
        case 5:
            let view = textField.superview as? FormSelectionList
            view?.showSelectionView(self.view)
            break
        default:
            allow = true
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
    
    //MARK: - Action Methods -
    
    @objc func sendQuery() {
        if validate() == true {
            
            let dateTF = tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.viewWithTag(100)?.viewWithTag(1) as! UITextField
            let mobileTF = tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.viewWithTag(200)?.viewWithTag(2) as! UITextField
            let guestTF = tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.viewWithTag(300)?.viewWithTag(3) as! UITextField
            let roomsTF = tableView.cellForRow(at: IndexPath(row: 3, section: 0))?.viewWithTag(400)?.viewWithTag(4) as! UITextField
            let menuTF = tableView.cellForRow(at: IndexPath(row: 4, section: 0))?.viewWithTag(500)?.viewWithTag(5) as! UITextField
            let vegSelected : Int = (menuTF.text?.contains(menuOptions[0].display_name))! ? 1 : 0
            let nonvegSelected : Int = (menuTF.text?.contains(menuOptions[1].display_name))! ? 1 : 0
            
            let requirement = "\"mobile\":\"\(mobileTF.text ?? "")\",\"people\":\"\(guestTF.text ?? "0")\",\"rooms_required\":\"\(roomsTF.text ?? "0")\",\"function_date\":\"\(dateTF.text ?? "")\",\"veg_selected\":\(vegSelected),\"nonveg_selected\":\(nonvegSelected)"
            
            viewModel.messageVenue(requirement, completion: {(success) in
                let msgVenueSuccessVC = MsgVenueSuccessController()
                msgVenueSuccessVC.viewModel.profile = self.viewModel.profile
                msgVenueSuccessVC.requirement = requirement
                self.navigationController?.pushViewController(msgVenueSuccessVC, animated: true)
            })
        }
    }
    
    func validate() -> Bool {
        var validate = true
        var error = ""
        
        let dateTF = tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.viewWithTag(100)?.viewWithTag(1) as! UITextField
        let mobileTF = tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.viewWithTag(200)?.viewWithTag(2) as! UITextField

        if dateTF.text?.count == 0 {
            validate = false
            error = "Please enter a function date"
            Helper.highlightTextField(dateTF)
        } else {
            do {
                let pass = try Validate.MobileNumber(mobileTF.text!)
                if !pass {
                    Helper.highlightTextField(mobileTF)
                    error = "Please enter a valid mobile number"
                    validate = false
                }
            } catch {
                print("catched error")
                return true
            }
        }
        
        if validate == false {
            self.present(Helper.showAlertWithMessage(error, _title: "Send Message", options: ["Okay"]), animated: true, completion: nil)
        }
        
        return validate
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
