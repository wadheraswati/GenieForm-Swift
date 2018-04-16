//
//  PortfolioScroller.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit
import AlamofireImage

class PortfolioScroller: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isPagingEnabled = true
    }
    
    func loadImages(images : [Images]) {
        var x : CGFloat = 0
        for image in images {
            let imgV = UIImageView(frame: CGRect(x: x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            imgV.af_setImage(withURL: URL(string: image.image_url.replacingOccurrences(of: "%%", with: "800"))!)
            imgV.contentMode = .scaleAspectFill
            imgV.clipsToBounds = true
            self.addSubview(imgV)
            x = x + self.bounds.size.width
        }
        self.contentSize = CGSize(width: x, height: self.bounds.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
