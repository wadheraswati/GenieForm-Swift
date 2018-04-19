//
//  aboutVendorCell.swift
//  GenieForm
//
//  Created by Swati Wadhera on 18/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AboutVendorCell: UITableViewCell {

    var titleLbl = UILabel()
    var subtitleLbl = TTTAttributedLabel(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        titleLbl = UILabel(frame: CGRect(x: 5, y: 10, width: self.bounds.size.width - 10, height: 25))
        titleLbl.textColor = AppColor.primaryBlackColor
        titleLbl.font = UIFont(name: AppFont.mediumFont, size: 15)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 1
        self.addSubview(titleLbl)
        
        subtitleLbl = TTTAttributedLabel(frame: CGRect(x: 5, y: titleLbl.frame.origin.y + titleLbl.frame.size.height, width: self.bounds.size.width - 10, height: 25))
        subtitleLbl.textColor = AppColor.primaryBlackColor
        subtitleLbl.font = UIFont(name: AppFont.mainFont, size: 15)
        subtitleLbl.textAlignment = .left
        subtitleLbl.numberOfLines = 3
        subtitleLbl.lineBreakMode = .byTruncatingTail
        self.addSubview(subtitleLbl)
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLbl.frame = CGRect(x: 5, y: 10, width: self.bounds.size.width - 10, height: 25)        
        subtitleLbl.frame = CGRect(x: 5, y: titleLbl.frame.origin.y + titleLbl.frame.size.height, width: self.bounds.size.width - 10, height: subtitleLbl.bounds.size.height)
    }
}
