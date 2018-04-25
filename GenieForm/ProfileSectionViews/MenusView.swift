//
//  MenusView.swift
//  GenieForm
//
//  Created by Swati Wadhera on 25/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

protocol MenusViewDelegate : class {
    func showMenuFiles()
}

class MenusView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var menuCollection : UICollectionView!
    var menuFiles = [MenuFiles]()
    
    weak var delegate : MenusViewDelegate?
    var showMoreBtn = UIButton()
    
    var count : Int = 0
    
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
        
        count = menuFiles.count
        
        let headingView = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        headingView.headingLbl.text = "Menus (\(count))"
        self.addSubview(headingView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        
        menuCollection = UICollectionView(frame: CGRect(x: 0, y: headingView.frame.origin.y + headingView.frame.size.height, width: self.bounds.size.width, height: 50) , collectionViewLayout: flowLayout)
        menuCollection.delegate = self
        menuCollection.dataSource = self
        menuCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        menuCollection.backgroundColor = AppColor.primaryWhiteColor
        menuCollection.isScrollEnabled = false
        self.addSubview(menuCollection)
        
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
        return menuFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! GridCollectionViewCell
        cell.isVideo = false
        
        let menu = menuFiles[indexPath.row]
        
        cell.titleLbl.isHidden = true
        cell.subtitleLbl.isHidden = true
        cell.imgCountLbl.isHidden = true
        cell.imgCountImgV.isHidden = true
        
        cell.gridImgV.af_setImage(withURL: URL(string:menu.menu_url.replacingOccurrences(of: "%%", with: "400"))!)
        
        cell.layoutSubviews()
        
        return cell
    }
    
    //TODO: Add collectionviewflowlayoutdelegate to call this method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.size.width - 15)/2, height: (self.bounds.size.width - 15)/2)
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        if menuCollection != nil {
            menuCollection.frame.size.height = menuCollection.contentSize.height
            
            let rows = CGFloat((min(4, menuFiles.count))/2 + (min(4, menuFiles.count))%2)
            menuCollection.frame.size.height = rows * ((self.bounds.size.width - 15)/2) + (rows == 1 ? 10 : 15)
            showMoreBtn.frame.origin.y = menuCollection.frame.origin.y + menuCollection.frame.size.height
        }
    }
    
    @objc func showMoreBtnClicked() {
        delegate?.showMenuFiles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

