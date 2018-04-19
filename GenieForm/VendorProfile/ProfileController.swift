//
//  ProfileController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, ProfileHeaderDelegate, AboutVendorDelegate {

    let viewModel : ProfileViewModel = ProfileViewModel()

    // main scrollView
    var containerScroll = UIScrollView()
    
    // sections
    var portfolioScroll = PortfolioScroller()
    var header = ProfileHeader()
    var aboutView = AboutVendor()
    
    let vendorID = "274"
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "Profile"
        
        initAPIData()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - API Calls -
    func initAPIData() {
        viewModel.getVendorProfile(vendorID: vendorID, isMember: false, completion: {(success) in
            if(success) {
                let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
                self.containerScroll = UIScrollView(frame: CGRect(x: 10, y: y, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - y))
                self.containerScroll.clipsToBounds = false
                self.view.addSubview(self.containerScroll)
                self.initPortfolioScroller()
                self.initUI()
                self.getVendorReviews()
            }
        })
    }
    func getVendorReviews() {
        viewModel.getVendorReviewInfo(vendorID : vendorID, isMember : false, completion: {(success) in
            if(success) {
                self.header.currentProfile = self.viewModel.profile
                self.header.updateReviewBox()
            }
        })
        
    }
    
    // MARK: UI Methods
    func initPortfolioScroller() {
        portfolioScroll = PortfolioScroller(frame: CGRect(x: -10, y: 0, width: self.view.bounds.size.width, height: (self.view.bounds.size.width * 3/4)))
        portfolioScroll.loadImages(images: viewModel.portfolio)
        containerScroll.addSubview(portfolioScroll)
    }
    
    func initUI() {
        
        let viewPhotosBtn = UIButton(type: .custom)
        viewPhotosBtn.setTitle("View Photos", for: .normal)
        viewPhotosBtn.setTitleColor(AppColor.primaryBlackColor, for: .normal)
        viewPhotosBtn.titleLabel?.font = UIFont.init(name: AppFont.mainFont, size: 15)
        viewPhotosBtn.backgroundColor = AppColor.primaryWhiteColor
        viewPhotosBtn.layer.cornerRadius = 3
        viewPhotosBtn.titleLabel?.numberOfLines = 1
        viewPhotosBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        viewPhotosBtn.sizeToFit()
        viewPhotosBtn.frame.origin.y = portfolioScroll.frame.origin.y + portfolioScroll.frame.size.height - 60 - viewPhotosBtn.bounds.size.height
        viewPhotosBtn.frame.origin.x = containerScroll.frame.size.width - viewPhotosBtn.bounds.size.width
        containerScroll.addSubview(viewPhotosBtn)
        
        let shareBtn = UIButton(type: .custom)
        shareBtn.setImage(UIImage(named: "shareContent"), for: .normal)
        shareBtn.backgroundColor = AppColor.primaryWhiteColor
        shareBtn.layer.cornerRadius = 3
        shareBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        shareBtn.sizeToFit()
        shareBtn.frame.origin.y = portfolioScroll.frame.origin.y + 10
        shareBtn.frame.origin.x = containerScroll.frame.size.width - shareBtn.bounds.size.width
        containerScroll.addSubview(shareBtn)
        
        header = ProfileHeader(frame: CGRect(x: 0, y: portfolioScroll.frame.origin.y + portfolioScroll.frame.size.height - 50, width: containerScroll.bounds.size.width, height: 100))
        header.currentProfile = viewModel.profile
        header.load()
        
        header.reviewBtn.addTarget(self, action: #selector(reviewBtnClicked), for: .touchUpInside)
        header.shortlistBtn.addTarget(self, action: #selector(shortlistVendor), for: .touchUpInside)
        header.queryBtn.addTarget(self, action: #selector(queryVendor), for: .touchUpInside)
        header.callBtn.addTarget(self, action: #selector(callVendor), for: .touchUpInside)

        header.sizeToFit()
        containerScroll.addSubview(header)
        
        aboutView = AboutVendor(frame: CGRect(x: 0, y: header.frame.origin.y + header.frame.size.height + 10, width: containerScroll.bounds.size.width, height: 100))
        aboutView.faqList = viewModel.faq
        aboutView.vendorName = viewModel.profile.name
        aboutView.information = viewModel.profile.information
        aboutView.delegate = self
        aboutView.load()
        aboutView.sizeToFit()
        containerScroll.addSubview(aboutView)
        self.perform(#selector(viewDidLayoutSubviews), with: nil, afterDelay: 0.5)
    }
    
    //MARK: AboutVendorDelegate Methods -
    func showMoreBtnClicked(_ full: Bool) {
        self.viewDidLayoutSubviews()
    }
    
    func showAboutVendor() {
        
        let darkView = UIView(frame: (self.view.window?.bounds)!)
        darkView.backgroundColor = AppColor.secondaryBlackColor.withAlphaComponent(0.5)
        darkView.tag = 101
        darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissInfoView)))
        
        let backView = UIView(frame: CGRect(x: 0, y: darkView.bounds.size.height, width: darkView.bounds.size.width, height: darkView.bounds.size.height))

        let aboutTitleLbl = UILabel(frame: CGRect(x: 0, y: 5, width: backView.bounds.size.width, height: 20))
        aboutTitleLbl.text = "About " + viewModel.profile.name
        aboutTitleLbl.font = UIFont.init(name: AppFont.mediumFont, size: 15)
        aboutTitleLbl.textColor = AppColor.primaryBlackColor
        aboutTitleLbl.textAlignment = .center
        aboutTitleLbl.lineBreakMode = .byTruncatingTail
        backView.addSubview(aboutTitleLbl)
        
        let infoLbl = UILabel(frame: CGRect(x: 0, y: aboutTitleLbl.frame.origin.y + aboutTitleLbl.frame.size.height, width: self.view.bounds.size.width - 20, height: 0))
        infoLbl.numberOfLines = 0
        infoLbl.textColor = AppColor.primaryBlackColor
        infoLbl.font = UIFont.init(name: AppFont.mainFont, size: 15)
        infoLbl.lineBreakMode = .byCharWrapping
        infoLbl.textAlignment = .justified
        infoLbl.text = viewModel.profile.information
        infoLbl.sizeToFit()
        
        backView.frame.size.height = infoLbl.frame.origin.y + infoLbl.frame.size.height + 10
        
        backView.backgroundColor = AppColor.primaryWhiteColor
        infoLbl.center = CGPoint(x: backView.bounds.size.width/2, y: (backView.bounds.size.height)/2 + (aboutTitleLbl.frame.size.height)/2)
        backView.addSubview(infoLbl)
        
        darkView.addSubview(backView)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.window?.addSubview(darkView)
            backView.frame.origin.y = darkView.bounds.size.height - backView.frame.size.height
        })
    }
    
    @objc func dismissInfoView() {
        UIView.animate(withDuration: 0.25, animations: {
            if let view = self.view.window?.viewWithTag(101) {
                view.alpha = 0
            }
        }, completion: {(success) in
            if let view = self.view.window?.viewWithTag(101) {
                view.removeFromSuperview()
            }
            })
    }
    
    //MARK: - ProfileHeaderDelegate Methods -
    
    @objc func reviewBtnClicked() {
        
    }
    
    @objc func shortlistVendor() {
        UIButton.showLoveLoadingAnimationOnButton(header.shortlistBtn)
        viewModel.shortlistVendor(vendorID: vendorID, completion: {(success) in
            if success {
                self.header.currentProfile = self.viewModel.profile
                self.header.updateShortlistBtn()
            }
        })
    }
    
    @objc func queryVendor() {
        
    }
    
    @objc func callVendor() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        header.sizeToFit()
        aboutView.sizeToFit()
        aboutView.frame.size.height = aboutView.showMoreBtn.frame.origin.y + aboutView.showMoreBtn.frame.size.height
        
        containerScroll.contentSize = CGSize(width: containerScroll.bounds.size.width, height: (aboutView.frame.origin.y) + (aboutView.frame.size.height) + 15)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
