//
//  VenueAreas.swift
//  GenieForm
//
//  Created by Swati Wadhera on 24/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

protocol VenueAreasDelegate : class {
    func showMoreBtnClicked(_ full : Bool)
}

class VenueAreas: UIView, UITableViewDelegate, UITableViewDataSource {

    var areaTableView = UITableView()
    var areas = [Area]()
    
    weak var delegate : VenueAreasDelegate?
    var showMoreBtn = UIButton()
    
    var showFull : Bool = false
    
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
        headingView.headingLbl.text = "Areas Available (\(areas.count))"
        self.addSubview(headingView)
        
        areaTableView = UITableView(frame: CGRect(x: 0, y: 30, width: self.bounds.size.width , height: 50), style: .plain)
        areaTableView.backgroundColor = AppColor.secondaryWhiteColor
        areaTableView.delegate = self
        areaTableView.dataSource = self
        areaTableView.rowHeight = 60
        areaTableView.separatorStyle = .none
        areaTableView.isScrollEnabled = false
        areaTableView.register(VenueAreaCell.self, forCellReuseIdentifier: "areaCell")
        self.addSubview(areaTableView)
        
        showMoreBtn = UIButton(type: .custom)
        showMoreBtn.backgroundColor = AppColor.secondaryWhiteColor
        showMoreBtn.setTitle("Show More", for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.init(name: AppFont.mainFont, size: 16)
        showMoreBtn.setTitleColor(AppColor.primaryRedColor, for: .normal)
        showMoreBtn.frame = CGRect(x: 0, y: areaTableView.frame.origin.y + areaTableView.frame.size.height, width: self.bounds.size.width, height: 40)
        showMoreBtn.addTarget(self, action: #selector(showMoreBtnClicked), for: .touchUpInside)
        self.addSubview(showMoreBtn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath) as! VenueAreaCell
        cell.selectionStyle = .none
        
        let area = areas[indexPath.row]
        cell.capacityLbl.text = "\(area.fixed_capacity) Seating | \(area.floating_capacity) Floating"
        cell.titleLbl.text = area.title
        cell.areaImgV.image = UIImage(named: "ven_banquet_type_\(area.indoor_outdoor)")
        
        cell.layoutSubviews()
        
        return cell
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        areaTableView.frame.size.height = areaTableView.contentSize.height
        
        if(showFull == false) {
            var height : CGFloat = 0
            if(areas.isEmpty == false) {
                for index in 1...min(2, areas.count) {
                    let indexPath = IndexPath(item: index - 1, section: 0)
                    if let cell = areaTableView.cellForRow(at: indexPath) as? VenueAreaCell {
                        height += cell.bounds.size.height
                        print(height)
                    }
                }
                areaTableView.frame.size.height = height // header height
            }
        }
        showMoreBtn.frame.origin.y = areaTableView.frame.origin.y + areaTableView.frame.size.height
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
