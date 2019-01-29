//
//  CustomImage.swift
//  iosProject
//
//  Created by Slim Karim on 03/05/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

@IBDesignable class CustomImage: UIImageView {
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: CGColor = UIColor.black.cgColor  {
        
        didSet{
            layer.borderColor = borderColor
        }
    }
 
    

}
