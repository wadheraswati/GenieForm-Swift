//
//  AboutVendor.swift
//  GenieForm
//
//  Created by Swati Wadhera on 18/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class AboutVendor: UIView, UITableViewDelegate, UITableViewDataSource {

    var faqList = [FAQ]()
    var information : String = ""
    let cellIdentifier = "AboutVendorCell"
    
    var aboutTable = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppColor.primaryWhiteColor
        self.layer.shadowColor = AppColor.secondaryBlackColor.cgColor;
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load() {
        aboutTable = UITableView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 50), style: .plain)
        aboutTable.delegate = self
        aboutTable.dataSource = self
        aboutTable.separatorStyle = .none
        aboutTable.register(AboutVendorCell.self, forCellReuseIdentifier: cellIdentifier)
        self.addSubview(aboutTable)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subtitleLbl = UILabel(frame: CGRect(x: 5, y: 0, width: self.bounds.size.width - 10, height: 25))
        subtitleLbl.textColor = AppColor.primaryBlackColor
        subtitleLbl.font = UIFont(name: AppFont.mainFont, size: 15)
        subtitleLbl.textAlignment = .left
        subtitleLbl.numberOfLines = 0
        subtitleLbl.lineBreakMode = .byTruncatingTail
        subtitleLbl.text = (indexPath.row == 0) ? information : faqList[indexPath.row - 1].answer
        subtitleLbl.sizeToFit()
        
        print("height - \(indexPath.row) - \(subtitleLbl.bounds.size.height + 35)")
        return subtitleLbl.bounds.size.height + 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AboutVendorCell
        
        if(indexPath.row == 0) {
            cell.titleLbl.text = "About Vendor"
            cell.subtitleLbl.text = information
        } else {
            let attrStr = NSMutableAttributedString(string: faqList[indexPath.row - 1].question)
            attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location: 0, length: attrStr.length))
            attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mediumFont, size: 15)!, range: NSRange(location: 0, length: attrStr.length))
            if let highlight = faqList[indexPath.row - 1].highlight_text {
                if highlight > 0 {
                    attrStr.addAttribute(.foregroundColor, value: AppColor.primaryRedColor, range: attrStr.mutableString.range(of: "WedMeGood"))
                }
            }
            cell.titleLbl.attributedText = attrStr
            //cell.titleLbl.text = faqList[indexPath.row - 1].question
            cell.subtitleLbl.text = faqList[indexPath.row - 1].answer
        }
        cell.layoutSubviews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func sizeToFit() {
        aboutTable.frame.size.height = aboutTable.contentSize.height
    }
    
    

}
