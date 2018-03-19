//
//  GenieFormController.swift
//  GenieForm
//
//  Created by Swati Wadhera on 17/03/18.
//  Copyright © 2018 Swati Wadhera. All rights reserved.
//

import UIKit

class GenieFormController: UIViewController {
    
    let viewModel : GenieViewModel = {
        return GenieViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initAPIData()
        
        initView()
    }
    
    func initAPIData() {
        viewModel.getFormData()
    }
    
    func initView() {
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

