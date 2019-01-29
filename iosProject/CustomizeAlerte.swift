//
//  CustomizeAlerte.swift
//  iosProject
//
//  Created by Slim Karim on 03/05/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addImage(image : UIImage) {
        
        let maxSize = CGSize(width : 135, height : 190)
        let imageSize = image.size
        var ratio : CGFloat!
        if (imageSize.width > imageSize.height){
            ratio = maxSize.width / imageSize.width
        } else {
            ratio = maxSize.height / imageSize.height

        }
        let scaledSize = CGSize(width : imageSize.width * ratio, height : imageSize.height * ratio)
        var resizedImage = image.imageWithSize(scaledSize)
        if(imageSize.height > imageSize.width){
            let left = (maxSize.width - resizedImage.size.width) / 2
            resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsetsMake(0, -left, 0, 0))
        }
        
        let imgAlerte = UIAlertAction(title : "", style : .default, handler : nil)
        imgAlerte.isEnabled = false
        
        imgAlerte.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAlerte)
        
    }
  
}
