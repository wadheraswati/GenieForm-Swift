//
//  FormCell.swift
//  GenieForm
//
//  Created by Swati Wadhera on 19/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import M13Checkbox

class SelectionCell: UITableViewCell {

    var fieldType : FieldType = FieldType.Label
    let checkbox = M13Checkbox()
    let titleLbl = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkbox.frame = CGRect(x: 5, y: 5, width: 25, height: 25)
        self.addSubview(checkbox)
        
        titleLbl.frame = CGRect(x: checkbox.frame.origin.x + checkbox.frame.size.width + 10, y: 5, width: self.bounds.size.width - 50, height: 25)
        titleLbl.textColor = AppConstants.primaryBlackColor
        titleLbl.font = UIFont.systemFont(ofSize: 15)
        titleLbl.textAlignment = .left
        titleLbl.numberOfLines = 1
        titleLbl.lineBreakMode = .byTruncatingTail
        self.addSubview(titleLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
