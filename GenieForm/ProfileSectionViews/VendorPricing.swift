//
//  VendorPricing.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

protocol VendorPricingDelegate : class {
    func messageVendor()
    func callVendor()
    func showHideFaq()
}

class VendorPricing: UIView, UITableViewDelegate, UITableViewDataSource {

    var pricing = [Pricing]()
    var faqList = [FAQ]()
    
    var backView = UIView()
    var faqTableView = UITableView()
    
    weak var delegate : VendorPricingDelegate?
    
    var showFAQ = true
    var dragBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = AppColor.primaryWhiteColor
        self.layer.shadowColor = AppColor.secondaryBlackColor.cgColor;
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
    }
    
    func loadData() {
        
        backView = UIView(frame: self.bounds)
        self.addSubview(backView)
        
        let messageVendorBtn = UIButton(type: .custom)
        messageVendorBtn.setTitle("", for: .normal)
        messageVendorBtn.titleLabel?.font = UIFont.init(name: AppFont.googleFont, size: 30)
        messageVendorBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        messageVendorBtn.sizeToFit()
        messageVendorBtn.addTarget(self, action: #selector(messageVendorBtnClicked), for: .touchUpInside)
        messageVendorBtn.frame = CGRect(x: backView.bounds.size.width - messageVendorBtn.bounds.size.width - 10, y: 0, width: messageVendorBtn.bounds.size.width, height: messageVendorBtn.bounds.size.height)
        messageVendorBtn.center = CGPoint(x: messageVendorBtn.center.x, y: backView.bounds.size.height/2)
        self.addSubview(messageVendorBtn)
        
        let callBtn = UIButton(type: .custom)
        callBtn.setTitle("", for: .normal)
        callBtn.titleLabel?.font = UIFont.init(name: AppFont.googleFont, size: 30)
        callBtn.setTitleColor(AppColor.primaryGreenColor, for: .normal)
        callBtn.sizeToFit()
        callBtn.addTarget(self, action: #selector(callBtnClicked), for: .touchUpInside)
        callBtn.frame = CGRect(x: messageVendorBtn.frame.origin.x - callBtn.bounds.size.width - 10, y: 0, width: callBtn.bounds.size.width, height: callBtn.bounds.size.height)
        callBtn.center = CGPoint(x: callBtn.center.x, y: backView.bounds.size.height/2)
        self.addSubview(callBtn)
        
        let x = CGFloat(5)
        var y = CGFloat(5)
        for pricingObj in pricing {
            
            let priceLbl = UILabel(frame: CGRect(x: 5, y: y, width: self.bounds.size.width - x*2, height: 0))
            let priceText = (pricingObj.show_inr == 0 ? "" : "₹ ") + "\(pricingObj.price) \(pricingObj.unit) \(pricingObj.label ?? "")"
            
            let attrStr = NSMutableAttributedString(string: priceText)
            attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mainFont, size: 15)!, range: NSRange(location: 0, length: attrStr.length))
            attrStr.addAttribute(.foregroundColor, value: AppColor.primaryRedColor, range: NSRange(location: 0, length: attrStr.length))
            attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.heavyFont, size: 15)!, range: attrStr.mutableString.range(of: "\(pricingObj.price)"))
            attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: attrStr.mutableString.range(of: "\(pricingObj.label ?? "")"))
            // TODO: Ask for striking logic
            // attrStr.addAttribute(.strikethroughStyle, value: 2, range: attrStr.mutableString.range(of: "\(pricingObj.price)"))
//            attrStr.addAttribute(.baselineOffset, value: 0, range: attrStr.mutableString.range(of: "\(pricingObj.price)"))
//
            priceLbl.attributedText = attrStr
            priceLbl.textAlignment = .left
            priceLbl.numberOfLines = 0
            priceLbl.lineBreakMode = .byWordWrapping
            priceLbl.sizeToFit()
            backView.addSubview(priceLbl)
            
            y += priceLbl.bounds.size.height + 5
        }
        
        backView.frame = CGRect(x: backView.frame.origin.x, y: backView.frame.origin.y, width: backView.frame.size.width, height: y)
        backView.center = CGPoint(x: backView.center.x, y: self.bounds.size.height/2)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showHideFaq))
       
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(showHideFaqSwiped))
        swipeUpGesture.direction = .down
        self.addGestureRecognizer(swipeUpGesture)

        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        
        self.addPricingFAQ()
        
        dragBtn = UIButton(type: .custom)
        dragBtn.setTitle("", for: .normal)
        dragBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        dragBtn.titleLabel?.font = UIFont.init(name: AppFont.googleFont, size: 15)
        dragBtn.backgroundColor = AppColor.primaryWhiteColor
        dragBtn.frame.size.height = 20
        dragBtn.frame.size.width = 20
        dragBtn.center = CGPoint(x: self.bounds.size.width/2, y: 0)
        dragBtn.layer.borderColor = AppColor.primaryRedColor.cgColor
        dragBtn.layer.borderWidth = 0.5
        dragBtn.layer.cornerRadius = dragBtn.bounds.size.width/2
        dragBtn.addTarget(self, action: #selector(showHideFaq), for: .touchUpInside)
        self.addSubview(dragBtn)
    }
    
    @objc func showHideFaqSwiped(_ sender : UIGestureRecognizer) {
        self.removeGestureRecognizer(sender)
        
        if showFAQ {
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(showHideFaqSwiped))
            swipeDownGesture.direction = .down
            self.addGestureRecognizer(swipeDownGesture)
            dragBtn.setTitle("", for: .normal)
        } else {
            dragBtn.setTitle("", for: .normal)
            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(showHideFaqSwiped))
            swipeUpGesture.direction = .down
            self.addGestureRecognizer(swipeUpGesture)
        }
        
        faqTableView.frame.size.height = faqTableView.contentSize.height + 10
        delegate?.showHideFaq()
    }
    
    @objc func showHideFaq() {
        for recognizer in self.gestureRecognizers! {
            if recognizer.isKind(of: UISwipeGestureRecognizer.self) {
                self.removeGestureRecognizer(recognizer) } }
        
        if showFAQ {
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(showHideFaqSwiped))
            swipeDownGesture.direction = .down
            self.addGestureRecognizer(swipeDownGesture)
            dragBtn.setTitle("", for: .normal)
        } else {
            dragBtn.setTitle("", for: .normal)
            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(showHideFaqSwiped))
            swipeUpGesture.direction = .down
            self.addGestureRecognizer(swipeUpGesture)
        }
        
        faqTableView.frame.size.height = faqTableView.contentSize.height + 10
        delegate?.showHideFaq()
    }
    
    func addPricingFAQ() {
        
        faqTableView = UITableView(frame: CGRect(x: 5, y: backView.frame.origin.y + backView.frame.size.height + 10, width: self.bounds.size.width - 10, height: 50), style: .plain)
        faqTableView.delegate = self
        faqTableView.dataSource = self
        faqTableView.separatorStyle = .none
        faqTableView.rowHeight = 50
        faqTableView.sectionHeaderHeight = 40
        faqTableView.isScrollEnabled = false
        faqTableView.register(AboutVendorCell.self, forCellReuseIdentifier: "faqCell")
        faqTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "faqHeader")
        self.addSubview(faqTableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "faqHeader")
      
        view!.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30)
        
        let lbl = UILabel(frame: CGRect(x: 5, y: 5, width: view!.frame.size.width - 10, height: 30))
        lbl.text = "Pricing Details"
        lbl.textColor = AppColor.primaryBlackColor
        lbl.font = UIFont.init(name: AppFont.heavyFont, size: 15)
        lbl.textAlignment = .left
        view?.addSubview(lbl)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! AboutVendorCell
        cell.selectionStyle = .none
        
        let faq = faqList[indexPath.row]
        
        cell.titleLbl.text = faq.question//.lowercased().capitalized
        cell.subtitleLbl.text = faq.answer + " \(faq.unit ?? "")"
        
        return cell
    }
    
    @objc func messageVendorBtnClicked() {
        delegate?.messageVendor()
    }
    
    @objc func callBtnClicked() {
        delegate?.callVendor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
