//
//  VideoListController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 25/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class VideoListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var viewModel = VideoListViewModel()
    
    var videoCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "Videos"
        
        initAPIData()
    }
    
    // MARK: - API Calls -
    func initAPIData() {
        viewModel.fetchVideos(completion: {success in
            if success {
                self.initUI()
            }
        })
    }
    
    // MARK: - UI Methods -
    func initUI() {
        let shareBarBtn = UIBarButtonItem(image: UIImage(named: "shareContent"), style: .plain, target: self, action: #selector(shareVideos))
        self.navigationItem.rightBarButtonItem = shareBarBtn
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 40
        
        let titleLbl = UILabel(frame: CGRect(x: 10, y: y, width: self.view.bounds.size.width - 20, height: 0))
        titleLbl.textColor = AppColor.primaryBlackColor
        titleLbl.font = UIFont.init(name: AppFont.heavyFont, size: 20)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.text = viewModel.profile.name
        titleLbl.sizeToFit()
        self.view.addSubview(titleLbl)
        
        let subtitleLbl = UILabel(frame: CGRect(x: 10, y: titleLbl.frame.origin.y + titleLbl.bounds.size.height + 5, width: self.view.bounds.size.width - 20, height: 0))
        subtitleLbl.textColor = AppColor.secondaryBlackColor
        subtitleLbl.font = UIFont.init(name: AppFont.heavyFont, size: 16)
        subtitleLbl.textAlignment = .left
        subtitleLbl.numberOfLines = 0
        subtitleLbl.lineBreakMode = .byWordWrapping
        subtitleLbl.text = "(\(viewModel.profile.category), \(viewModel.profile.base_city))"
        subtitleLbl.sizeToFit()
        self.view.addSubview(subtitleLbl)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        
        videoCollection = UICollectionView(frame: CGRect(x: 5, y: subtitleLbl.frame.origin.y + subtitleLbl.frame.size.height + 20, width: self.view.bounds.size.width - 10, height: self.view.bounds.size.height - (subtitleLbl.frame.origin.y + subtitleLbl.frame.size.height) - 40) , collectionViewLayout: flowLayout)
        videoCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.backgroundColor = AppColor.invisibleLightColor
        videoCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "videoCell")
        self.view.addSubview(videoCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! GridCollectionViewCell
        cell.isVideo = true
        
        let video = viewModel.videoList[indexPath.row]
        cell.titleLbl.text = "\(video.video_title)"
        cell.gridImgV.af_setImage(withURL: URL(string:video.video_image.replacingOccurrences(of: "%%", with: "400"))!)
        
        cell.layoutSubviews()
        
        return cell
    }
    
    //TODO: Add collectionviewflowlayoutdelegate to call this method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (videoCollection.bounds.size.width - 15)/2, height: (videoCollection.bounds.size.width - 15)/2)
    }
    
    // MARK: - Action Methods -
    @objc func shareVideos() {
        Helper.share(viewModel.shareURL, self)
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

