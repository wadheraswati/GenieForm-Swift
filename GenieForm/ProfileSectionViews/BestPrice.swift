//
//  BestPrice.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class BestPrice: UIView {

    var displayPhone = ""
    
    var bestPriceImgV = UIImageView()
    var bestPriceLbl = UILabel()
    
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
        
        bestPriceImgV = UIImageView(frame: CGRect(x: 10, y: 0, width: 40, height: 25))
        bestPriceImgV.image = UIImage(named: "best-price")
        bestPriceImgV.sizeToFit()
        self.addSubview(bestPriceImgV)
        
        bestPriceLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - bestPriceImgV.bounds.size.width - bestPriceImgV.frame.origin.x*3, height: 0))
        bestPriceLbl.textAlignment = .left
        bestPriceLbl.numberOfLines = 0
        bestPriceLbl.lineBreakMode = .byWordWrapping
        
        let text = "WedMeGood has a best price guarantee at this venue. Call " + displayPhone
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mainFont, size: 16)!, range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryRedColor, range: attrStr.mutableString.range(of: "WedMeGood"))
        attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.heavyFont, size: 16)!, range: attrStr.mutableString.range(of: displayPhone))
        bestPriceLbl.attributedText = attrStr
        
        bestPriceLbl.sizeToFit()
        bestPriceLbl.frame.origin.x = bestPriceImgV.frame.origin.x + bestPriceImgV.bounds.size.width + 10
        self.addSubview(bestPriceLbl)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        bestPriceImgV.center = CGPoint(x: bestPriceImgV.center.x, y: self.bounds.size.height/2)
        bestPriceLbl.center = CGPoint(x: bestPriceLbl.center.x, y: self.bounds.size.height/2)
    }
    
}
