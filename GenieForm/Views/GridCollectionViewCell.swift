//
//  GridCollectionViewCell.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    var titleLbl = UILabel()
    var subtitleLbl = UILabel()
    
    var imgCountLbl = UILabel()
    var imgCountImgV = UIImageView()
    
    var gridImgV = UIImageView()
    var gradientLayer = CAGradientLayer()
    
    var playBtn = UIButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [AppColor.primaryBlackColor.withAlphaComponent(0.6).cgColor, AppColor.invisibleLightColor.cgColor, AppColor.primaryBlackColor.withAlphaComponent(0.6).cgColor]
        gradientLayer.locations = [0.0, 0.3, 0.9, 1.0]
        
        gridImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        gridImgV.contentMode = .scaleAspectFill
        gridImgV.clipsToBounds = true
        self.addSubview(gridImgV)
        
        imgCountLbl = UILabel(frame : CGRect(x: self.bounds.size.width - 30, y: 5, width: 25, height: 20))
        imgCountLbl.textColor = AppColor.primaryWhiteColor
        imgCountLbl.textAlignment = .right
        imgCountLbl.numberOfLines = 1
        imgCountLbl.lineBreakMode = .byTruncatingTail
        imgCountLbl.font = UIFont.init(name: AppFont.mediumFont, size: 14)
        self.addSubview(imgCountLbl)
        
        imgCountImgV = UIImageView(frame: CGRect(x: imgCountLbl.frame.origin.x - 25, y: 5, width: 20, height: 20))
        imgCountImgV.image = #imageLiteral(resourceName: "vendor_list_album_count")
        self.addSubview(imgCountImgV)
        
        subtitleLbl = UILabel(frame: CGRect(x: 5, y: self.bounds.size.height - 25, width: self.bounds.size.width - 10, height: 20))
        subtitleLbl.numberOfLines = 1
        subtitleLbl.textColor = AppColor.primaryWhiteColor
        subtitleLbl.font = UIFont.init(name: AppFont.mainFont, size: 12)
        subtitleLbl.lineBreakMode = .byTruncatingTail
        subtitleLbl.textAlignment = .left
        self.addSubview(subtitleLbl)
        
        titleLbl = UILabel(frame: CGRect(x: 5, y: subtitleLbl.frame.size.height - 25, width: self.bounds.size.width - 10, height: 20))
        titleLbl.numberOfLines = 1
        titleLbl.textColor = AppColor.primaryWhiteColor
        titleLbl.font = UIFont.init(name: AppFont.mainFont, size: 14)
        titleLbl.lineBreakMode = .byTruncatingTail
        titleLbl.textAlignment = .left
        self.addSubview(titleLbl)
        
        playBtn = UIButton(type: .custom)
        playBtn.setTitle("", for: .normal)
        playBtn.setTitleColor(AppColor.primaryWhiteColor, for: .normal)
        playBtn.titleLabel?.font = UIFont.init(name: AppFont.googleFont, size: 50)
        playBtn.sizeToFit()
        playBtn.frame.size.height = playBtn.bounds.size.width
        playBtn.clipsToBounds = true
        playBtn.center = self.center
        self.addSubview(playBtn)
        
        self.layer.insertSublayer(gradientLayer, above: gridImgV.layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)

        gridImgV.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        
        imgCountLbl.sizeToFit()
        imgCountLbl.frame =  CGRect(x: self.bounds.size.width - imgCountLbl.bounds.size.width - 5, y: 5, width: imgCountLbl.bounds.size.width, height: 20)
        
        imgCountImgV.frame = CGRect(x: imgCountLbl.frame.origin.x - 20, y: 5, width: 20, height: 20)
       
        subtitleLbl.sizeToFit()
        subtitleLbl.frame = CGRect(x: 5, y: self.bounds.size.height - subtitleLbl.bounds.size.height, width: self.bounds.size.width - 10, height: subtitleLbl.bounds.size.height)
       
        titleLbl.sizeToFit()
        titleLbl.frame = CGRect(x: 5, y: subtitleLbl.frame.origin.y - titleLbl.bounds.size.height, width: self.bounds.size.width - 10, height: titleLbl.bounds.size.height)
        
        playBtn.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
}
