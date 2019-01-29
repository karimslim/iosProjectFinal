//
//  ActualityCell.swift
//  iosProject
//
//  Created by Slim Karim on 14/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

class ActualityCell: UITableViewCell {

    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var titleCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
