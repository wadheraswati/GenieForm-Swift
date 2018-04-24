//
//  MessageVenueController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 23/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class MessageVenueController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, FormSelectionListDelegate {

    var submitBtn = UIButton()
    var tableView = UITableView()
    var profileVM = ProfileViewModel()
    
    var menuOptions = [Options]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Send Message"
        self.view.backgroundColor = AppColor.primaryWhiteColor
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 40
        self.navigationController?.navigationBar.tintColor = AppColor.primaryBlackColor
        
        submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("Check availability & prices", for: .normal)
        submitBtn.setTitleColor(AppColor.primaryWhiteColor, for: .normal)
        submitBtn.contentHorizontalAlignment = .center
        submitBtn.backgroundColor = AppColor.primaryRedColor
        submitBtn.titleLabel?.font = UIFont.init(name: AppFont.mediumFont, size: 16)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.addTarget(self, action: #selector(sendQuery), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        
        let headingLbl = UILabel(frame: CGRect(x: 10, y: y, width: self.view.bounds.size.width - 20, height: 0))
        headingLbl.text = "Fill out the form with your details and the vendor will get in touch with you"
        headingLbl.textColor = AppColor.primaryRedColor
        headingLbl.textAlignment = .center
        headingLbl.font = UIFont.init(name: AppFont.mainFont, size: 15)
        headingLbl.numberOfLines = 0
        headingLbl.lineBreakMode = .byWordWrapping
        headingLbl.sizeToFit()
        headingLbl.center = CGPoint(x: self.view.bounds.size.width/2, y: headingLbl.center.y)
        self.view.addSubview(headingLbl)
        
        tableView = UITableView(frame: CGRect(x: 10, y: headingLbl.frame.origin.y + headingLbl.bounds.size.height + 20, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - submitBtn.frame.size.height - headingLbl.bounds.size.height - y - 40) , style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        // initialise menu options for drop down in FormSelectionList
        var vegMenuOption = Options()
        vegMenuOption.id = 1
        vegMenuOption.display_name = "Veg Menu"
        vegMenuOption.name = "veg-menu"
        menuOptions.append(vegMenuOption)

        var nonvegMenuOption = Options()
        nonvegMenuOption.id = 2
        nonvegMenuOption.display_name = "Non Veg Menu"
        nonvegMenuOption.name = "non-veg-menu"
        menuOptions.append(nonvegMenuOption)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

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
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame.size.height -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame.size.height += keyboardSize.height
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
            
            let requirement = "{\"requirement\":{\"mobile\":\"\(mobileTF.text ?? "")\",\"people\":\"\(guestTF.text ?? "0")\",\"rooms_required\":\"\(roomsTF.text ?? "0")\",\"function_date\":\"\(dateTF.text ?? "")\",\"veg_selected\":\(vegSelected),\"nonveg_selected\":\(nonvegSelected)}}"
            
            profileVM.messageVenue(requirement, completion: {(success) in
                
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
            highlightTextField(dateTF)
        } else {
            do {
                let pass = try validateMobileNumber(mobileTF.text!)
                if !pass {
                    highlightTextField(mobileTF)
                    error = "Please enter a valid mobile number"
                    validate = false
                }
            } catch {
                print("catched error")
                return true
            }
        }
        
        if validate == false {
            self.showAlertWithMessage(error)
        }
        
        return validate
    }
    
    func validateMobileNumber(_ text : String) throws -> Bool {
        if text.count == 0 { return false }

        let regex = "([+]?1+[-]?)?+([(]?+([0-9]{3})?+[)]?)?+[-]?+[0-9]{3}+[-]?+[0-9]{4}"
        _ = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: text)
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

    func showAlertWithMessage(_ msg : String) {
        let alert = UIAlertController.init(title: "Send Message", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
