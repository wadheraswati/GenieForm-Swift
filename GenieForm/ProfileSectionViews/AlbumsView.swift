//
//  Albums.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import AlamofireImage

protocol AlbumsViewDelegate : class {
    func showMoreBtnClicked(_ full : Bool)
}

class AlbumsView : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var albumCollection : UICollectionView!
    var albums = [Album]()
    
    weak var delegate : AlbumsViewDelegate?
    var showMoreBtn = UIButton()
    
    var showFull : Bool = false
    var count : Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = AppColor.invisibleLightColor
        self.layer.shadowColor = AppColor.secondaryBlackColor.cgColor;
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    func loadData() {
        
        let headingView = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        headingView.headingLbl.text = "Albums (\(Int(count)))"
        self.addSubview(headingView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        albumCollection = UICollectionView(frame: CGRect(x: 0, y: headingView.frame.origin.y + headingView.frame.size.height, width: self.bounds.size.width, height: 50) , collectionViewLayout: flowLayout)
        albumCollection.delegate = self
        albumCollection.dataSource = self
        albumCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "albumCell")
        albumCollection.backgroundColor = AppColor.primaryWhiteColor
        albumCollection.isScrollEnabled = false
        self.addSubview(albumCollection)
        
        let remaining = Int(count) - min(4, Int(count))
        showMoreBtn = UIButton(type: .custom)
        showMoreBtn.backgroundColor = AppColor.secondaryWhiteColor
        showMoreBtn.setTitle("View \(remaining) More", for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.init(name: AppFont.mainFont, size: 16)
        showMoreBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        showMoreBtn.frame = CGRect(x: 0, y: albumCollection.frame.origin.y + albumCollection.frame.size.height, width: self.bounds.size.width, height: (remaining > 0 ? 40 : 0))
        showMoreBtn.isHidden = remaining > 0 ? false : true
        showMoreBtn.addTarget(self, action: #selector(showMoreBtnClicked), for: .touchUpInside)
        self.addSubview(showMoreBtn)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! GridCollectionViewCell
        cell.isVideo = false
        
        let album = albums[indexPath.row]
        cell.imgCountLbl.text = "\(album.image_count)"
        cell.titleLbl.text = "\(album.title)"
        cell.subtitleLbl.text = "\(album.location ?? "")"
        
        cell.gridImgV.af_setImage(withURL: URL(string:  album.cover_pic_url.replacingOccurrences(of: "%%", with: "400"))!)
        cell.layoutSubviews()
        
        return cell
    }

    //TODO: Add collectionviewflowlayoutdelegate to call this method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.size.width - 15)/2, height: (self.bounds.size.width - 15)/2)
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        if albumCollection != nil {
            albumCollection.frame.size.height = albumCollection.contentSize.height
            
            let rows = CGFloat((min(4, albums.count))/2 + (min(4, albums.count))%2)
            albumCollection.frame.size.height = rows * ((self.bounds.size.width - 15)/2) + 15
            
            showMoreBtn.frame.origin.y = albumCollection.frame.origin.y + albumCollection.frame.size.height
        }
    }
    
    @objc func showMoreBtnClicked() {
        showFull = !showFull
        showMoreBtn.setTitle(showFull ? "Show Less" : "Show More", for: .normal)
        delegate?.showMoreBtnClicked(showFull)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
