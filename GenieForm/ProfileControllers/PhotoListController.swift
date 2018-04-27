//
//  PhotoListController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 27/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class PhotoListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var photoCollection : UICollectionView!
    
    var images = [Images]()
    var profile = Profile()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.title = "Gallery"
        
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 40
        
        let titleLbl = UILabel(frame: CGRect(x: 5, y: y, width: self.view.bounds.size.width - 10, height: 0))
        titleLbl.textColor = AppColor.primaryBlackColor
        titleLbl.font = UIFont.init(name: AppFont.heavyFont, size: 20)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.text = profile.name//viewModel.profile.name
        titleLbl.sizeToFit()
        self.view.addSubview(titleLbl)
        
        let subtitleLbl = UILabel(frame: CGRect(x: 5, y: titleLbl.frame.origin.y + titleLbl.bounds.size.height + 5, width: self.view.bounds.size.width - 10, height: 0))
        subtitleLbl.textColor = AppColor.secondaryBlackColor
        subtitleLbl.font = UIFont.init(name: AppFont.heavyFont, size: 16)
        subtitleLbl.textAlignment = .left
        subtitleLbl.numberOfLines = 0
        subtitleLbl.lineBreakMode = .byWordWrapping
        subtitleLbl.text = ""//"(\(profile.category), \(viewModel.profile.base_city))"
        subtitleLbl.sizeToFit()
        self.view.addSubview(subtitleLbl)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        
        photoCollection = UICollectionView(frame: CGRect(x: 5, y: subtitleLbl.frame.origin.y + subtitleLbl.frame.size.height + 20, width: self.view.bounds.size.width - 10, height: self.view.bounds.size.height - (subtitleLbl.frame.origin.y + subtitleLbl.frame.size.height) - 30) , collectionViewLayout: flowLayout)
        photoCollection.backgroundColor = AppColor.primaryWhiteColor
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        self.view.addSubview(photoCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! GridCollectionViewCell
       
        cell.gridImgV.af_setImage(withURL: URL(string: images[indexPath.row].image_url.replacingOccurrences(of: "%%", with: "800"))!)
        
        //TODO: Add love button to grid cell
        cell.imgCountImgV.isHidden = true
        cell.playBtn.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 10, height: (collectionView.bounds.size.width/2 - 10))
    }    
}
