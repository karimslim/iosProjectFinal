//
//  CustomTeamCell.swift
//  iosProject
//
//  Created by Slim Karim on 15/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

class CustomTeamCell: UITableViewCell {
    
    @IBOutlet weak var eqImage: UIImageView!
    @IBOutlet weak var eqName: UILabel!
    @IBOutlet weak var coupeNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func SetTeam(team:Team)
    {
        self.eqName.text = team.name!
        self.coupeNumber.text = team.coupeNumb!
        self.eqImage.image = UIImage(named: team.image!)
        
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

