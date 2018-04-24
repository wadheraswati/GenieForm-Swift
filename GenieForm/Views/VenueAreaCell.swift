//
//  VenueAreaCell.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class VenueAreaCell: UITableViewCell {

    var areaImgV = UIImageView()
    var capacityLbl = UILabel()
    var titleLbl = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.backgroundColor = AppColor.primaryWhiteColor
        
        areaImgV = UIImageView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        self.addSubview(areaImgV)
        
        capacityLbl = UILabel(frame: CGRect(x: areaImgV.frame.origin.x + areaImgV.frame.size.width + 5, y: 15, width: self.bounds.size.width - (areaImgV.frame.origin.x + areaImgV.frame.size.width) - 10 , height: 0))
        capacityLbl.textColor = AppColor.primaryBlackColor
        capacityLbl.font = UIFont.init(name: AppFont.mediumFont, size: 15)
        capacityLbl.textAlignment = .left
        capacityLbl.numberOfLines = 1
        capacityLbl.lineBreakMode = .byTruncatingTail
        self.addSubview(capacityLbl)
        
        titleLbl = UILabel(frame: CGRect(x: capacityLbl.frame.origin.x, y: capacityLbl.frame.origin.y + capacityLbl.bounds.size.height + 5, width: capacityLbl.frame.size.width, height: 0))
        titleLbl.textColor = AppColor.primaryBlackColor
        titleLbl.font = UIFont.init(name: AppFont.mainFont, size: 13)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 1
        titleLbl.lineBreakMode = .byTruncatingTail
        self.addSubview(titleLbl)
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
        
        areaImgV.frame =  CGRect(x: 5, y: 5, width: 50, height: 50)
        
        capacityLbl.sizeToFit()
        capacityLbl.frame = CGRect(x: areaImgV.frame.origin.x + areaImgV.frame.size.width + 5, y: capacityLbl.frame.origin.y, width: self.bounds.size.width - (areaImgV.frame.origin.x + areaImgV.frame.size.width) - 10 , height: capacityLbl.bounds.size.height)
        
        titleLbl.sizeToFit()
        titleLbl.frame = CGRect(x: capacityLbl.frame.origin.x, y: capacityLbl.frame.origin.y + capacityLbl.frame.size.height + 5, width: titleLbl.bounds.size.width, height: titleLbl.frame.size.height)

        
    }

}
