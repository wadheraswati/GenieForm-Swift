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
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "Profile"
        
        initAPIData()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - API Calls -
    func initAPIData() {
        viewModel.getVendorProfile(vendorID: "274", isMember: false, completion: {(success) in
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
        viewModel.getVendorReviewInfo(vendorID : "274", isMember : false, completion: {(success) in
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
    
    //MARK: - ProfileHeaderDelegate Methods -
    
    @objc func reviewBtnClicked() {
        
    }
    
    @objc func shortlistVendor() {
        UIButton.showLoveLoadingAnimationOnButton(header.shortlistBtn)
        viewModel.shortlistVendor(vendorID: "274", completion: {(success) in
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
