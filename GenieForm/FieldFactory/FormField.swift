//
//  FormTextField.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class FormTextField: UIView {
    
    var fieldTF = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fieldTF = UITextField(frame: CGRect(x: 10, y: 5, width: frame.size.width - 20, height: 40))
        fieldTF.font = UIFont.systemFont(ofSize: 15)
        fieldTF.textColor = .black
        fieldTF.textAlignment = .left
        fieldTF.keyboardType = .default
        fieldTF.layer.borderColor = AppConstants.textFieldBorderColor.cgColor
        fieldTF.layer.borderWidth = 1
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        fieldTF.leftView = view
        fieldTF.leftViewMode = .always
        self.addSubview(fieldTF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FormMobileNumber: UIView {
    
    var fieldTF = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        fieldTF = UITextField(frame: CGRect(x: 10, y: 5, width: frame.size.width - 20, height: 40))
        fieldTF.font = UIFont.systemFont(ofSize: 15)
        fieldTF.textColor = .black
        fieldTF.textAlignment = .left
        fieldTF.layer.borderColor = AppConstants.textFieldBorderColor.cgColor
        fieldTF.layer.borderWidth = 1
        fieldTF.keyboardType = .numbersAndPunctuation
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        fieldTF.leftView = view
        fieldTF.leftViewMode = .always
        self.addSubview(fieldTF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FormEmail: UIView {
    
    var fieldTF = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fieldTF = UITextField(frame: CGRect(x: 10, y: 5, width: frame.size.width - 20, height: 40))
        fieldTF.font = UIFont.systemFont(ofSize: 15)
        fieldTF.textColor = .black
        fieldTF.textAlignment = .left
        fieldTF.keyboardType = .emailAddress
        fieldTF.layer.borderColor = AppConstants.textFieldBorderColor.cgColor
        fieldTF.layer.borderWidth = 1
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        fieldTF.leftView = view
        fieldTF.leftViewMode = .always
        self.addSubview(fieldTF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FormDatepicker: UIView {
    
    var fieldTF = UITextField()
    var datePicker = UIDatePicker()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fieldTF = UITextField(frame: CGRect(x: 10, y: 5, width: frame.size.width - 20, height: 40))
        fieldTF.font = UIFont.systemFont(ofSize: 15)
        fieldTF.textColor = .black
        fieldTF.textAlignment = .left
        fieldTF.keyboardType = .default
        fieldTF.layer.borderColor = AppConstants.textFieldBorderColor.cgColor
        fieldTF.layer.borderWidth = 1
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        fieldTF.leftView = view
        fieldTF.leftViewMode = .always
        self.addSubview(fieldTF)
        
        let clickBtn = UIButton(type: .custom)
        clickBtn.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        clickBtn.addTarget(self, action: #selector(showDatePickerInView(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(clickBtn)
        
        datePicker.date = NSDate() as Date
        datePicker.minimumDate = NSDate() as Date
    }
    
    @objc func showDatePickerInView(_ view : UIView) {
        view.endEditing(true)
        
        let darkView = UIView(frame: view.bounds)
        darkView.alpha = 0
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.75)
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(setDate(_:)))
        darkView.addGestureRecognizer(gestureRecognizer)
        view.window?.addSubview(darkView)
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = AppConstants.secondaryWhiteColor
        darkView.addSubview(datePicker)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: darkView.bounds.size.height - 216 - 44, width: view.bounds.size.width, height: 44))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDate(_:)))
        doneBtn.tintColor = AppConstants.primaryRedColor
        toolBar.items = [spacer, doneBtn, spacer]
        darkView.addSubview(toolBar)
        darkView.alpha = 1
    }
    
    @objc func setDate(_ sender : AnyObject) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FormSelectionList: UIView, UITableViewDataSource, UITableViewDelegate {
   
    
    let fieldTF = UITextField()
    var values : [Options] = [Options]()
    let selectionCellIdentifier = "selectionCell"
    var multiSelect : Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fieldTF.frame = CGRect(x: 10, y: 5, width: frame.size.width - 20, height: 40)
        fieldTF.font = UIFont.systemFont(ofSize: 15)
        fieldTF.textColor = .black
        fieldTF.textAlignment = .left
        fieldTF.layer.borderColor = AppConstants.textFieldBorderColor.cgColor
        fieldTF.layer.borderWidth = 1
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        fieldTF.leftView = view
        fieldTF.leftViewMode = .always
        self.addSubview(fieldTF)
        
        let clickBtn = UIButton(type: .custom)
        clickBtn.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        clickBtn.addTarget(self, action: #selector(showSelectionView(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(clickBtn)
}

    @objc func showSelectionView(_ view : UIView) {
        
        let darkView = UIView(frame: view.bounds)
        darkView.alpha = 0
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.75)
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(dismissSelector(_:)))
        darkView.addGestureRecognizer(gestureRecognizer)
        view.window?.addSubview(darkView)
        
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0.0, y: darkView.bounds.size.height - CGFloat(self.values.count * 35), width: darkView.bounds.size.width, height: CGFloat(self.values.count * 35))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectionCell.self, forCellReuseIdentifier: self.selectionCellIdentifier)
        darkView.addSubview(tableView)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: darkView.bounds.size.height - tableView.bounds.size.height - 44, width: view.bounds.size.width, height: 44))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSelector(_:)))
        doneBtn.tintColor = AppConstants.primaryRedColor
        toolBar.items = [spacer, doneBtn, spacer]
        darkView.addSubview(toolBar)
        darkView.alpha = 1
        tableView.reloadData()
    }
    
    @objc func dismissSelector(_ sender : AnyObject) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.selectionCellIdentifier, for: indexPath) as! SelectionCell
        cell.titleLbl.text = self.values[indexPath.row].display_name
        cell.checkbox.checkState = ((indexPath.row)%2 == 0) ? .checked : .unchecked
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.values.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


