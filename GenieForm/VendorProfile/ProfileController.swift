//
//  ProfileController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    let viewModel : ProfileViewModel = ProfileViewModel()

    // main scrollView
    var containerScroll = UIScrollView()
    
    // sections
    var portfolioScroll = PortfolioScroller()
    var header = ProfileHeader()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "Profile"
        
        initAPIData()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initAPIData() {
        viewModel.isMember = false
        viewModel.vendorID = "274"
        viewModel.getVendorProfile(completion: {(success) in
            if(success) {
                let y = (self.navigationController?.navigationBar.bounds.size.height)! + 20
                self.containerScroll = UIScrollView(frame: CGRect(x: 10, y: y, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - y))
                self.containerScroll.clipsToBounds = false
                self.view.addSubview(self.containerScroll)
                self.initPortfolioScroller()
                self.initUI()
            }
        })
        
        viewModel.getVendorReviewInfo(completion: {(success) in
            if(success) {
                self.header.updateReviewBoxForProfile(profile: self.viewModel.profile)
            }
        })
        
    }
    
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
        header.loadHeaderWithProfile(profile: viewModel.profile)
        header.sizeToFit()
        containerScroll.addSubview(header)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let lastview = containerScroll.subviews.last {
            containerScroll.contentSize = CGSize(width: containerScroll.bounds.size.width, height: (lastview.frame.origin.y) + (lastview.frame.size.height))
        }
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
