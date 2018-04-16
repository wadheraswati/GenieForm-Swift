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

    var portfolioScroll = PortfolioScroller()
    var containerScroll = UIScrollView()
    
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
                self.containerScroll = UIScrollView(frame: CGRect(x: 0, y: y, width: self.view.bounds.size.width, height: self.view.bounds.size.height - y))
                self.containerScroll.backgroundColor = AppColor.primaryCreamColor
                self.view.addSubview(self.containerScroll)
                self.initPortfolioScroller()
            }
        })
        
    }
    
    func initPortfolioScroller() {
        portfolioScroll = PortfolioScroller(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: (self.view.bounds.size.width * 3/4)))
        portfolioScroll.loadImages(images: viewModel.portfolio)
        containerScroll.addSubview(portfolioScroll)
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
