//
//  DetailsActualityController.swift
//  iosProject
//
//  Created by Slim Karim on 26/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import SDWebImage


class DetailsActualityController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var imageActuality: UIImageView!
    @IBOutlet weak var titleActuality: UILabel!
    
    @IBOutlet weak var authorActuality: UILabel!
    @IBOutlet weak var descriptionActuality: UILabel!
    
    var image = String()
    var titleAc = ""
    var descAc = ""
    var author = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showProgressView(view)
        let delay = max(0.0, 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            LoadingOverlay.shared.hideProgressView()
            
        }
        
        
        imageActuality.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "coupedumonde"))
        titleActuality.text! = titleAc
        descriptionActuality.text! = descAc
        
    }
 
   



}
