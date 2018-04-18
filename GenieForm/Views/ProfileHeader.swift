//
//  ProfileHeader.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {

    var ctaView = UIView()
    var currentProfile = Profile()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppColor.primaryWhiteColor
        self.layer.shadowColor = AppColor.secondaryBlackColor.cgColor;
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    func loadHeaderWithProfile(profile : Profile) {
        
        currentProfile = profile
        var y : CGFloat = 10
        let categoryImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        categoryImgV.image = UIImage(named: (profile.membership_id == AppConstants.MembershipType.HandPicked.rawValue) ? "venD_handpicked" : "venD_featured")
        categoryImgV.sizeToFit()
        categoryImgV.frame.origin.x = self.bounds.size.width - categoryImgV.bounds.size.width
        self.addSubview(categoryImgV)
        
        let nameLbl = UILabel(frame: CGRect(x: 10, y: y, width: self.bounds.size.width - categoryImgV.bounds.size.width, height: 0))
        nameLbl.numberOfLines = 2
        nameLbl.lineBreakMode = .byTruncatingTail
        nameLbl.minimumScaleFactor = 0.5
        nameLbl.textAlignment = .justified
        nameLbl.adjustsFontSizeToFitWidth = true
        //nameLbl.backgroundColor = AppColor.primaryCreamColor
        nameLbl.font = UIFont(name: AppFont.heavyFont, size: 20)
        nameLbl.textColor = AppColor.primaryBlackColor
        nameLbl.text = profile.name
        nameLbl.sizeToFit()
        self.addSubview(nameLbl)
        
        y = y + nameLbl.bounds.size.height + 10
        
        let cityLbl = UILabel(frame : CGRect(x: 10, y: y, width: self.bounds.size.width - 20, height: 0))
        
        var text = ""
        if profile.address != nil {
            text = " " + currentProfile.city + ((profile.address != nil) ? " (View on Map)" : "") }
        else {
            text = " " + currentProfile.city }
        
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.addAttribute(.font, value: UIFont(name: AppFont.mediumFont, size: 15)!, range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttribute(.baselineOffset, value: NSNumber.init(value: -2), range: NSRange(location: 0, length: 1))
        let range = attrStr.mutableString.range(of: "(View On Map)", options: .caseInsensitive)
       
        if(range.length > 0) {
            attrStr.addAttribute(.font, value: UIFont(name: "googleicon", size: 16)!, range: NSRange(location: 0, length: 1))
            // used attrStr.mutableString instead of attrStr.string to get NSRange type value instead of <Range.index> type value
            
            attrStr.addAttribute(.foregroundColor, value: AppColor.secondaryBlackColor, range: range)
        }
        cityLbl.attributedText = attrStr
        cityLbl.textAlignment = .left
        cityLbl.sizeToFit()
        self.addSubview(cityLbl)
        
        y = y + cityLbl.bounds.size.height + 10
        
        if profile.address != nil {
            let addressLbl = UILabel(frame: CGRect(x: 10, y: y, width: self.bounds.size.width - 20, height: 0))
            addressLbl.text = profile.address?.last?.display_address
            addressLbl.textColor = AppColor.secondaryBlackColor
            addressLbl.textAlignment = .left
            addressLbl.font = UIFont(name: AppFont.mainFont, size: 15)
            addressLbl.numberOfLines = 0
            addressLbl.lineBreakMode = .byTruncatingTail
            addressLbl.sizeToFit()
            self.addSubview(addressLbl)
            
            y = y + addressLbl.bounds.size.height + 5
        }
        
        ctaView = UIView(frame: CGRect(x: 0, y: y, width: self.bounds.size.width, height: 60))
        ctaView.backgroundColor = AppColor.secondaryWhiteColor
        self.addSubview(ctaView)
        
        addCTAs()
    }
    
    func createBtn(_ titleImgString : String, _ text : String, _ frame : CGRect) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.setTitleColor(AppColor.primaryBlackColor, for: .normal)
        btn.frame = frame
        btn.tintColor = AppColor.primaryBlackColor
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.75
        btn.autoresizingMask = .flexibleWidth
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        var resultStr = ""
        if titleImgString.elementsEqual("") {
            resultStr = text
        } else {
            resultStr = titleImgString + "\n" + text
        }
        
        let attrStr = NSMutableAttributedString(string: resultStr)
        // setting background color to complete text
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location : 0, length : attrStr.length))
        // setting font to complete text
        attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mainFont, size: 14)!, range: NSRange(location: titleImgString.count, length: attrStr.length - titleImgString.count))
        
        // setting font based on googleicon or fontawesome
        
        attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.googleFont, size: 25)!, range: NSRange(location: 0, length: titleImgString.count))
        
        // setting button colors
        if(text.contains("Message")) {
            attrStr.addAttribute(.foregroundColor, value: AppColor.primaryRedColor, range: NSRange(location : 0, length : titleImgString.count)) }
        else if(text.contains("Call")){
            attrStr.addAttribute(.foregroundColor, value: AppColor.primaryGreenColor, range: NSRange(location : 0, length : titleImgString.count))
        } else if(text.contains("Reviews")) {
            let range = attrStr.mutableString.range(of: "\n")
            attrStr.addAttribute(.baselineOffset, value: NSNumber.init(value: -5), range: NSRange(location: range.location + 1, length:      attrStr.length - range.location - 1))
        }
        
        attrStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrStr.length))
        btn.setAttributedTitle(attrStr, for: .normal)
        
        return btn;
    }
    
    func addCTAs() {

        let reviewText = " ★ 0.0 \nNo Reviews"
        
        let reviewBtn = createBtn("", reviewText, CGRect(x: 0, y: 0, width: ctaView.bounds.size.width/4, height: ctaView.bounds.size.height))
        reviewBtn.tag = 100
        ctaView.addSubview(reviewBtn)
        
        let shortlistBtn = createBtn("", "Shortlist", CGRect(x: ctaView.bounds.size.width/4, y: 0, width: ctaView.bounds.size.width/4, height: ctaView.bounds.size.height))
        ctaView.addSubview(shortlistBtn)

        let queryBtn = createBtn("", "Message", CGRect(x: (ctaView.bounds.size.width/4)*2, y: 0, width: ctaView.bounds.size.width/4, height: ctaView.bounds.size.height))
        ctaView.addSubview(queryBtn)

        let callBtn = createBtn("", "Call", CGRect(x: (ctaView.bounds.size.width/4)*3, y: 0, width: ctaView.bounds.size.width/4, height: ctaView.bounds.size.height))
        ctaView.addSubview(callBtn)

        //        NSString *star = [NSString stringWithFormat:@"%.1f",[[[vendorDataDict valueForKey:@"profile"] valueForKey:@"vendor_rating"] floatValue]];
//        NSString *reviewCount = [NSString stringWithFormat:@"%lu",(unsigned long)[reviewsArray count]];
//        UIButton *reviewsButton = [self createButtonWithTitle:@"" withText:[NSString stringWithFormat:@" ★ %@ \n(%@ Review%@)", star, reviewCount, reviewsArray.count > 1?@"s":@""] andAction:@"scrollToReviews"
//            andFrame:CGRectMake(0, y, (headerView.bounds.size.width/4), 50)];
//        [reviewsButton setBackgroundColor:[kSecondaryWhiteColor colorWithAlphaComponent:0.3]];
//        if([reviewCount isEqualToString:@"No Reviews"] || [reviewCount isEqualToString:@"0"] || !reviewCount) {
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"No Reviews"]];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:MAIN_FONT size:12] range:NSMakeRange(0, attrStr.length)];
//            [attrStr addAttribute:NSForegroundColorAttributeName value:kPrimaryBlackColor range:NSMakeRange(0, attrStr.length)];
//            reviewsButton.titleLabel.attributedText = attrStr;
//            [reviewsButton setAttributedTitle:attrStr forState:UIControlStateNormal];
//        } else {
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" ★ %@ \n(%@ Review%@)", star, reviewCount, reviewsArray.count > 1?@"s":@""]];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:MAIN_FONT size:12] range:NSMakeRange(0, attrStr.length)];
//            [attrStr addAttribute:NSForegroundColorAttributeName value:kPrimaryBlackColor range:NSMakeRange(0, attrStr.length)];
//            NSRange ran = [attrStr.string rangeOfString:@"\n"];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:MAIN_FONT size:14] range:NSMakeRange(0, ran.location)];
//            [attrStr addAttribute:NSBackgroundColorAttributeName value:[ATWMGJsonParser getVenRatingBackgroundColor:[star floatValue]] range:NSMakeRange(0, ran.location)];
//            [attrStr addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInteger:-5] range:NSMakeRange(ran.location + 1, attrStr.length - ran.location - 1)];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"googleicon" size:14] range:NSMakeRange(0, 1)];
//            [attrStr addAttribute:NSForegroundColorAttributeName value:kPrimaryWhiteColor range:NSMakeRange(0, ran.location)];
//
//            [reviewsButton setAttributedTitle:attrStr forState:UIControlStateNormal];
//        }
//
//        [headerView addSubview:reviewsButton];
    }
    
    func updateReviewBoxForProfile(profile : Profile) {
        currentProfile = profile
        let reviewBtn = ctaView.viewWithTag(100) as! UIButton
        //if(reviewBtn)
        
        let rating = String.init(format: " ★ %@ ",(currentProfile.reviewInfo?.vendor_rating) ?? "0.0")
        let reviewCount = Double((currentProfile.reviewInfo?.reviews_count)!)
        let reviews : String = (reviewCount > 0) ? (String.init(format: "%d Review%@", Int(reviewCount), (reviewCount) > 1 ? "s" : "")) : "No Reviews"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let resultStr = rating + "\n" + reviews
        
        let attrStr = NSMutableAttributedString(string: resultStr)
        attrStr.addAttribute(.font, value: UIFont.init(name: AppFont.mainFont, size: 14)!, range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryBlackColor, range: NSRange(location: 0, length: attrStr.length))
        let range = attrStr.mutableString.range(of: "\n")
        attrStr.addAttribute(.backgroundColor, value: UIColor(rating : (currentProfile.reviewInfo?.vendor_rating) ?? "0.0")  , range: NSRange(location: 0, length: range.location))
        attrStr.addAttribute(.baselineOffset, value: NSNumber.init(value: -5.5), range: NSRange(location: range.location + 1, length:      attrStr.length - range.location - 1))
        attrStr.addAttribute(.foregroundColor, value: AppColor.primaryWhiteColor, range: attrStr.mutableString.range(of: rating))
        attrStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrStr.length))
        reviewBtn.setAttributedTitle(attrStr, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeToFit() {
        self.frame.size.height = ctaView.frame.origin.y + ctaView.frame.size.height
    }
    
}
