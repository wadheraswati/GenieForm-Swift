//
//  AboutVendor.swift
//  GenieForm
//
//  Created by Swati Wadhera on 18/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

protocol AboutVendorDelegate: class {
    func showMoreBtnClicked(_ full : Bool)
    func showAboutVendor()
}
class AboutVendor: UIView, UITableViewDelegate, UITableViewDataSource {

    var faqList = [FAQ]()
    var information = ""
    var vendorName = ""
    weak var delegate : AboutVendorDelegate?

    let cellIdentifier = "AboutVendorCell"
    
    var aboutTable = UITableView()
    var showMoreBtn = UIButton()
    
    var showFull = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppColor.secondaryWhiteColor
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
        aboutTable.isScrollEnabled = false
        aboutTable.backgroundColor = AppColor.primaryWhiteColor
        aboutTable.register(AboutVendorCell.self, forCellReuseIdentifier: cellIdentifier)
        self.addSubview(aboutTable)
        
        showMoreBtn = UIButton(type: .custom)
        showMoreBtn.backgroundColor = AppColor.secondaryWhiteColor
        showMoreBtn.setTitle("Read More", for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.init(name: AppFont.mainFont, size: 16)
        showMoreBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        showMoreBtn.frame = CGRect(x: 0, y: aboutTable.frame.origin.y + aboutTable.frame.size.height, width: self.bounds.size.width, height: 40)
        showMoreBtn.addTarget(self, action: #selector(showMoreBtnClicked), for: .touchUpInside)
        self.addSubview(showMoreBtn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subtitleLbl = UILabel(frame: CGRect(x: 5, y: 0, width: self.bounds.size.width - 10, height: 25))
        subtitleLbl.textColor = AppColor.primaryBlackColor
        subtitleLbl.font = UIFont(name: AppFont.mainFont, size: 15)
        subtitleLbl.textAlignment = .left
        subtitleLbl.numberOfLines = (indexPath.row == 0) ? 3 : 0
        subtitleLbl.lineBreakMode = .byCharWrapping
        subtitleLbl.text = (indexPath.row == 0) ? information : faqList[indexPath.row - 1].answer
        if(indexPath.row == 0) {
            if subtitleLbl.numberOfLines == 3 {
                let continueText = "Continue Reading"
                if let value = subtitleLbl.text {
                    let substring = value.dropLast(value.count - 150)
                    subtitleLbl.text = String(substring) + "... " + continueText
                }
            }
        }
        subtitleLbl.sizeToFit()
        print("height - \(indexPath.row) - \(subtitleLbl.bounds.size.height + 40)")
        return subtitleLbl.bounds.size.height + 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AboutVendorCell
        
        cell.selectionStyle = .none
        if(indexPath.row == 0) {
            cell.titleLbl.text = "About " + vendorName
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
            cell.subtitleLbl.text = faqList[indexPath.row - 1].answer
            cell.subtitleLbl.textColor = AppColor.secondaryBlackColor
            if let fade = faqList[indexPath.row - 1].fade {
                cell.subtitleLbl.alpha = (fade == 0) ? 1 : 0.5
            }
        }
        
        cell.subtitleLbl.sizeToFit()

        if(indexPath.row == 0) {
            if cell.subtitleLbl.numberOfLines == 3 {
                let continueText = "Continue Reading"
                if let value = cell.subtitleLbl.text {
                    let substring = value.dropLast(value.count - 150)
                    let newStr = String(substring) + "... " + continueText
                    let attrStr = NSMutableAttributedString(string: newStr)
                    attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location: 0, length: attrStr.length))
                    attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mainFont, size: 15)!, range: NSRange(location: 0, length: attrStr.length))
                    attrStr.addAttribute(.foregroundColor, value: AppColor.secondaryBlackColor, range: attrStr.mutableString.range(of: continueText))
                    attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mediumFont, size: 15)!, range: attrStr.mutableString.range(of: continueText))
                    cell.subtitleLbl.attributedText = attrStr
                }
            }
        }
        
        cell.subtitleLbl.sizeToFit()
        cell.layoutSubviews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            delegate?.showAboutVendor()

            // show about vendor text full
        }
    }
    
    override func sizeToFit() {
        aboutTable.frame.size.height = aboutTable.contentSize.height
        
        if(showFull == false) {
            var height : CGFloat = 0
            if(faqList.isEmpty == false) {
                for index in 1...min(3, faqList.count) {
                    print(aboutTable.visibleCells.count)
                    let indexPath = IndexPath(item: index - 1, section: 0)
                    if let cell = aboutTable.cellForRow(at: indexPath) as? AboutVendorCell {
                        height += cell.bounds.size.height
                        print(height)
                        
                    }
                }
                aboutTable.frame.size.height = height
            }
        }
        showMoreBtn.frame.origin.y = aboutTable.frame.origin.y + aboutTable.frame.size.height
    }
    
    @objc func showMoreBtnClicked() {
        showFull = !showFull
        showMoreBtn.setTitle(showFull ? "Read Less" : "Read More", for: .normal)
        delegate?.showMoreBtnClicked(showFull)
    }
}
