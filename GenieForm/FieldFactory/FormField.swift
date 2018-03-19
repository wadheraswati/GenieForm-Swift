//
//  FormTextField.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import M13Checkbox

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
    var darkView = UIView()
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
    
        datePicker.date = NSDate() as Date

        //self.addSubview(clickBtn)
        
    }
    
    @objc func showDatePickerInView(_ view : UIView) {
        view.endEditing(true)
        
        darkView.frame = view.bounds
        darkView.alpha = 0
        darkView.tag = 100
        darkView.isUserInteractionEnabled = true
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.75)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSelector(_:)))
        darkView.addGestureRecognizer(gestureRecognizer)
        view.window?.addSubview(darkView)
        
        datePicker.minimumDate = NSDate() as Date
        datePicker.backgroundColor = AppConstants.secondaryWhiteColor
        datePicker.frame = CGRect(x: 0, y: darkView.bounds.size.height - 216, width: view.bounds.size.width, height: datePicker.frame.size.height)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        fieldTF.text = dateFormatter.string(from: datePicker.date)
        darkView.removeFromSuperview()
    }
    
    @objc func dismissSelector(_ sender : AnyObject) {
        darkView.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol FormSelectionListDelegate: class {
    func checkboxStateChanged(_ checkbox : M13Checkbox)
    func completedSelection(_ values : [Options])
}

class FormSelectionList: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    let fieldTF = UITextField()
    var values : [Options] = [Options]()
    let tableView = UITableView()

    let selectionCellIdentifier = "selectionCell"

    var multiSelect : Bool = false
    var darkView = UIView()
    
    weak var delegate : FormSelectionListDelegate?

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
        //self.addSubview(clickBtn)
}

    @objc func showSelectionView(_ view : UIView) {
        
        view.endEditing(true)
        
        darkView.frame = view.bounds
        darkView.alpha = 0
        darkView.tag = 100
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.75)
        darkView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSelector(_:)))
        gestureRecognizer.delegate = self
        gestureRecognizer.cancelsTouchesInView = false
        darkView.addGestureRecognizer(gestureRecognizer)
        view.window?.addSubview(darkView)
        
        tableView.frame = CGRect(x: 0.0, y: darkView.bounds.size.height - CGFloat(self.values.count * 40), width: darkView.bounds.size.width, height: CGFloat(self.values.count * 40))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectionCell.self, forCellReuseIdentifier: self.selectionCellIdentifier)
        darkView.addSubview(tableView)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: darkView.bounds.size.height - tableView.bounds.size.height - 44, width: view.bounds.size.width, height: 44))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishedSelection(_:)))
        doneBtn.tintColor = AppConstants.primaryRedColor
        toolBar.items = [spacer, doneBtn, spacer]
        if(multiSelect) {darkView.addSubview(toolBar)}
        darkView.alpha = 1
        tableView.reloadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableView) == true {
            return false
        }
        return true
    }
    
    
    @objc func dismissSelector(_ sender : AnyObject) {
        if(multiSelect){
            self.finishedSelection(sender)
        }
        darkView.removeFromSuperview()
    }
    
    @objc func finishedSelection(_ sender : AnyObject) {
        var row = 0
        var selectedValues : [Options] = [Options]()
        var valueStr : String = ""
        for value in self.values {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? SelectionCell
            if(cell?.checkbox.checkState == M13Checkbox.CheckState.checked) {
                selectedValues.append(value)
                valueStr = valueStr.appendingFormat("%@, ", value.display_name)
            }
            
            row += 1
        }
        if(valueStr.hasSuffix(", ")) {
            let finalStr = valueStr.prefix(valueStr.count - 2)
            self.fieldTF.text = String(finalStr)
        }
        delegate?.completedSelection(selectedValues)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.selectionCellIdentifier, for: indexPath) as! SelectionCell
        cell.titleLbl.text = self.values[indexPath.row].display_name
        cell.multiselect = self.multiSelect
        cell.checkbox.isUserInteractionEnabled = false
        //cell.checkbox.addTarget(self, action: Selector("checkboxTapped:"), for: UIControlEvents.touchUpInside)
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.values.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? SelectionCell
        if(multiSelect) {
            cell?.checkbox.toggleCheckState()
            //delegate?.checkboxStateChanged(cell?.checkbox)
        } else {
            fieldTF.text = cell?.titleLbl.text
            self.dismissSelector(cell!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


