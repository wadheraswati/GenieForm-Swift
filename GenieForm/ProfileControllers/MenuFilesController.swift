//
//  MenuFilesController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 25/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import Alamofire

class MenuFilesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var menuCollection : UICollectionView!
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppColor.secondaryWhiteColor
        self.navigationItem.title = "Menus"
        
        initUI()
    }
    
//    // MARK: - API Calls -
//    func initAPIData() {
//        viewModel.fetchAlbums(completion: {success in
//            if success {
//                self.initUI()
//            }
//        })
//    }
    
    // MARK: - UI Methods -
    func initUI() {
    
        let y = (self.navigationController?.navigationBar.bounds.size.height)! + 40
        
        let titleLbl = UILabel(frame: CGRect(x: 5, y: y, width: self.view.bounds.size.width - 10, height: 0))
        titleLbl.textColor = AppColor.primaryBlackColor
        titleLbl.font = UIFont.init(name: AppFont.heavyFont, size: 20)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.text = viewModel.profile.name
        titleLbl.sizeToFit()
        self.view.addSubview(titleLbl)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        
        menuCollection = UICollectionView(frame: CGRect(x: 5, y: titleLbl.frame.origin.y + titleLbl.frame.size.height + 20, width: self.view.bounds.size.width - 10, height: self.view.bounds.size.height - (titleLbl.frame.origin.y + titleLbl.frame.size.height) - 40) , collectionViewLayout: flowLayout)
        menuCollection.delegate = self
        menuCollection.dataSource = self
        menuCollection.backgroundColor = AppColor.invisibleLightColor
        menuCollection.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        self.view.addSubview(menuCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! GridCollectionViewCell
        cell.isVideo = false
        
        let menu = viewModel.menuFiles[indexPath.row]
        
        cell.titleLbl.isHidden = true
        cell.subtitleLbl.isHidden = true
        cell.imgCountLbl.isHidden = true
        cell.imgCountImgV.isHidden = true
        
        cell.gridImgV.loadImageUsingCache(withUrl: menu.menu_url)

        //cell.gridImgV.af_setImage(withURL: URL(string:menu.menu_url)!)
        
        cell.layoutSubviews()
        
        return cell
    }
    
    //TODO: Add collectionviewflowlayoutdelegate to call this method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (menuCollection.bounds.size.width - 15)/2, height: (menuCollection.bounds.size.width - 15)/2)
    }
    
    // MARK: - Action Methods -
//    @objc func shareAlbum() {
//        UIButton.share(viewModel.shareURL, self)
//    }
//    
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

