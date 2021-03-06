//
//  Videos.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import AlamofireImage

protocol VideosViewDelegate : class {
    func showVideos()
}

class VideosView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var videoCollection : UICollectionView!
    var videos = [Video]()
    
    weak var delegate : VideosViewDelegate?
    var showMoreBtn = UIButton()
    
    var showFull : Bool = false
    var count : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = AppColor.invisibleLightColor
        UIUpdates.addShadow(self.layer)

    }
    
    func loadData() {
        
        let headingView = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        headingView.headingLbl.text = "Videos (\(count))"
        self.addSubview(headingView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        
        videoCollection = UICollectionView(frame: CGRect(x: 0, y: headingView.frame.origin.y + headingView.frame.size.height, width: self.bounds.size.width, height: 50) , collectionViewLayout: flowLayout)
        videoCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "videoCell")
        videoCollection.backgroundColor = AppColor.primaryWhiteColor
        videoCollection.isScrollEnabled = false
        self.addSubview(videoCollection)
        
        let remaining = count - min(4, count)
        showMoreBtn = UIButton(type: .custom)
        showMoreBtn.backgroundColor = AppColor.secondaryWhiteColor
        showMoreBtn.setTitle("View \(remaining) More", for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.init(name: AppFont.mainFont, size: 16)
        showMoreBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        showMoreBtn.frame = CGRect(x: 0, y: videoCollection.frame.origin.y + videoCollection.frame.size.height, width: self.bounds.size.width, height: (remaining > 0 ? 40 : 0))
        showMoreBtn.isHidden = remaining > 0 ? false : true
        showMoreBtn.addTarget(self, action: #selector(showMoreBtnClicked), for: .touchUpInside)
        self.addSubview(showMoreBtn)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! GridCollectionViewCell

        cell.imgCountImgV.isHidden = true

        let video = videos[indexPath.row]
        cell.titleLbl.text = "\(video.video_title)"
        cell.gridImgV.af_setImage(withURL: URL(string:video.video_image.replacingOccurrences(of: "%%", with: "400"))!)
        
        cell.layoutSubviews()
        
        return cell
    }
    
    //TODO: Add collectionviewflowlayoutdelegate to call this method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.size.width - 15)/2, height: (self.bounds.size.width - 15)/2)
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        if videoCollection != nil {
            videoCollection.frame.size.height = videoCollection.contentSize.height
            
            let rows = CGFloat((min(4, videos.count))/2 + (min(4, videos.count))%2)
            videoCollection.frame.size.height = rows * ((self.bounds.size.width - 15)/2) + (rows == 1 ? 10 : 15)
            showMoreBtn.frame.origin.y = videoCollection.frame.origin.y + videoCollection.frame.size.height
        }
    }
    
    @objc func showMoreBtnClicked() {
        delegate?.showVideos()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
