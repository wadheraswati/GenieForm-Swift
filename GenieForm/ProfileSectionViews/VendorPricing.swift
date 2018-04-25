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
}

class VendorPricing: UIView {

    var pricing = [Pricing]()
    
    var backView = UIView()
    
    weak var delegate : VendorPricingDelegate?
    
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
