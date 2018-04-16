//
//  PortfolioScroller.swift
//  GenieForm
//
//  Created by Swati Wadhera on 16/04/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class PortfolioScroller: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isPagingEnabled = true
    }
    
    func loadImages(images : [Images]) {
        var x : CGFloat = 0
        for image in images {
            let imgV = UIImageView(frame: CGRect(x: x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            do {
                let imgData = try Data(contentsOf: URL(string: image.image_url.replacingOccurrences(of: "%%", with: "800"))!)
                let downloadedImg = UIImage.init(data: imgData)
                imgV.image = downloadedImg
                self.addSubview(imgV)
                x = x + self.bounds.size.width
            }
            catch {
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
