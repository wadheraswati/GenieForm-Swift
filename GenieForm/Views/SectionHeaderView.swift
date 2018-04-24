//
//  SectionHeaderView.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {

    var headingLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        headingLbl = UILabel(frame: CGRect(x: 5, y: 0, width: self.bounds.size.width, height: 30))
        headingLbl.textColor = AppColor.primaryBlackColor
        headingLbl.font = UIFont.init(name: AppFont.heavyFont, size: 18)
        headingLbl.textAlignment = .left
        headingLbl.numberOfLines = 1
        headingLbl.lineBreakMode = .byTruncatingTail
        self.addSubview(headingLbl)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headingLbl.frame = CGRect(x: 5, y: 0, width: self.bounds.size.width, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
