//
//  MsgVenueSuccessController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 26/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

public enum FunctionType: String {
    case prewedding = "Pre Wedding"
    case wedding = "Wedding"
}

public enum FunctionTime : String {
    case day = "Day"
    case evening = "Evening"
}

public enum Alcohol : String {
    case yes = "Yes"
    case no = "No"
}

class MsgVenueSuccessController: UIViewController, UITableViewDelegate, UITableViewDataSource, FormSelectionListDelegate, UITextFieldDelegate {

    var submitBtn = UIButton()
    var tableView = UITableView()
    var profileVM = ProfileViewModel()
    
    var bestPrice = BestPrice()
    
    var functionTypeValues = [Options(id: FunctionType.prewedding.hashValue, display_name: FunctionType.prewedding.rawValue, name: FunctionType.prewedding.rawValue), Options(id: FunctionType.wedding.hashValue, display_name: FunctionType.wedding.rawValue, name: FunctionType.wedding.rawValue)]
    
    var functionTimeValues = [Options(id: FunctionTime.day.hashValue, display_name: FunctionTime.day.rawValue, name: FunctionTime.day.rawValue), Options(id: FunctionTime.evening.hashValue, display_name: FunctionTime.evening.rawValue, name: FunctionTime.evening.rawValue)]
    
    var alcoholServedValues = [Options(id: Alcohol.yes.hashValue, display_name: Alcohol.yes.rawValue, name: Alcohol.yes.rawValue), Options(id: Alcohol.no.hashValue, display_name: Alcohol.no.rawValue, name: Alcohol.no.rawValue)]
    
    override func viewDidLoad() {
        
        self.title = "Send Message"
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20

        submitBtn = UIButton(type: .custom)
        submitBtn.setTitle("Submit Details", for: .normal)
        submitBtn.setTitleColor(AppColor.primaryWhiteColor, for: .normal)
        submitBtn.contentHorizontalAlignment = .center
        submitBtn.backgroundColor = AppColor.primaryRedColor
        submitBtn.titleLabel?.font = UIFont.init(name: AppFont.mediumFont, size: 16)
        submitBtn.frame = CGRect(x: 0, y: self.view.bounds.size.height - 40, width: self.view.bounds.size.width, height: 40)
        submitBtn.addTarget(self, action: #selector(sendQuery), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        
        let headingLbl = UILabel(frame: CGRect(x: 10, y: y + 10, width: self.view.bounds.size.width - 20, height: 0))
        headingLbl.text = "Thanks for submitting your details"
        headingLbl.textColor = AppColor.primaryGreenColor
        headingLbl.textAlignment = .center
        headingLbl.font = UIFont.init(name: AppFont.mainFont, size: 20)
        headingLbl.numberOfLines = 0
        headingLbl.lineBreakMode = .byWordWrapping
        headingLbl.sizeToFit()
        headingLbl.center = CGPoint(x: self.view.bounds.size.width/2, y: headingLbl.center.y)
        self.view.addSubview(headingLbl)
        
        let subheadingLbl = UILabel(frame: CGRect(x: 10, y: headingLbl.frame.origin.y + headingLbl.bounds.size.height + 15, width: self.view.bounds.size.width - 20, height: 0))
        subheadingLbl.text = "Share few more details with us and we'll get back to you within 3 working hours"
        subheadingLbl.textColor = AppColor.primaryBlackColor
        subheadingLbl.textAlignment = .center
        subheadingLbl.font = UIFont.init(name: AppFont.mainFont, size: 15)
        subheadingLbl.numberOfLines = 0
        subheadingLbl.lineBreakMode = .byWordWrapping
        subheadingLbl.sizeToFit()
        subheadingLbl.center = CGPoint(x: self.view.bounds.size.width/2, y: subheadingLbl.center.y)
        self.view.addSubview(subheadingLbl)
        
        bestPrice = BestPrice(frame: CGRect(x: 10, y: subheadingLbl.frame.origin.y + subheadingLbl.frame.size.height + 10, width: self.view.bounds.size.width - 20, height: 0))
        bestPrice.displayPhone = profileVM.profile.concierge_display_phone!
        bestPrice.loadData()
        bestPrice.frame.size.height = bestPrice.bestPriceLbl.frame.size.height + 20
        bestPrice.layoutSubviews()
        self.view.addSubview(bestPrice)
        
        tableView = UITableView(frame: CGRect(x: 10, y: bestPrice.frame.origin.y + bestPrice.bounds.size.height + 20, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - submitBtn.frame.size.height - bestPrice.bounds.size.height - bestPrice.frame.origin.y - 40) , style: .plain)
        tableView.backgroundColor = AppColor.secondaryWhiteColor

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        self.viewDidLayoutSubviews()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = AppColor.invisibleLightColor
        
        var view = FormSelectionList()
        if cell.viewWithTag(indexPath.row + 1) == nil {
            view = FormSelectionList(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
            view.tag = (indexPath.row + 1)*100
            cell.addSubview(view)
        }
        view.delegate = self
        
        view.multiSelect = false
        view.fieldTF.delegate = self
        
        view.fieldTF.tag = indexPath.row + 1
        
        switch indexPath.row + 1 {
        case 1:
            view.fieldTF.placeholder = "Function Type"
            view.fieldTF.title = "Function Type"
            view.values = functionTypeValues
            view.fieldTF.text = functionTypeValues.first?.display_name
            break
        case 2:
            view.fieldTF.placeholder = "Function Time"
            view.fieldTF.title = "Function Time"
            view.values = functionTimeValues
            view.fieldTF.text = functionTimeValues.first?.display_name
            break
        case 3:
            view.fieldTF.placeholder = "Alcohol Served"
            view.fieldTF.title = "Alcohol Served"
            view.values = alcoholServedValues
            view.fieldTF.text = alcoholServedValues.first?.display_name
            break
        default:
            break
        }
        return cell
    }
    
    //MARK: - FormSelectionDelegate Methods -
    func completedSelection(_ values: [Options], _ textField: UITextField) {
        
    }
    
    func selectedValue(_ textField: UITextField) {
        
    }
    
    //MARK: - UITextFieldDelegate Methods -
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let view = textField.superview as? FormSelectionList
        view?.showSelectionView(self.view)
        
        return false
    }
    
    func sendQuery() {
        
        let requirement = "{\"requirement\":{\"function_type\":\"%@\",\"timeValue\":\"%@\",\"alcohol\":\"%@\"}}"
        
        profileVM.updateMessageVenue(requirement, completion: {(success) in
            let msgVenueSuccessVC = MsgVenueSuccessController()
            msgVenueSuccessVC.profileVM = self.profileVM
            self.navigationController?.pushViewController(msgVenueSuccessVC, animated: true)
        })
    }
    
//    func validate() -> Bool {
//        var validate = true
//
//        return validate
//    }
    
    override func viewDidLayoutSubviews() {
        bestPrice.frame.origin.y = bestPrice.frame.origin.y + (bestPrice.frame.size.height == 0 ? 0 : 10)
        
        tableView.frame.origin.y = bestPrice.frame.origin.y + bestPrice.frame.size.height + 20
        tableView.frame.size.height = self.view.bounds.size.height - submitBtn.frame.size.height - bestPrice.bounds.size.height - bestPrice.frame.origin.y - 40
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
