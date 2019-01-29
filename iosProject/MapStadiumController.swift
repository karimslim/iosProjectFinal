//
//  MapStadiumController.swift
//  iosProject
//
//  Created by Slim Karim on 27/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

class MapStadiumController: UIViewController {
    
    
    
    @IBOutlet weak var stadiumImg: UIImageView!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var stadiumDesc: UILabel!
    @IBOutlet weak var equipeRes: UILabel!
    @IBOutlet weak var capacite: UILabel!
  
    
    var image = String()
    var titleStadium = ""
    var descStadium = ""
    var capaciteStadium = ""
    var equipeStadium = ""
    var longitude = ""
    var latitude = ""
    var lat = Int()
    var long = Int()
    override func viewDidLoad() {
        LoadingOverlay.shared.showProgressView(view)
        let delay = max(0.0, 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            LoadingOverlay.shared.hideProgressView()
            
        }
        super.viewDidLoad()
        stadiumImg.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "tunisie"))
        stadiumName.text! = titleStadium
        stadiumDesc.text! = descStadium
        equipeRes.text! = equipeStadium
        capacite.text! = capaciteStadium
        lat = Int(latitude)!
        long = Int(longitude)!
        

    }
    @IBAction func visitStadium(_ sender: Any) {
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visitStadium"{
            if let destinationVC = segue.destination as? MapsViewController {
                destinationVC.latitude = lat
                destinationVC.longitude = long
                destinationVC.nameStadium = titleStadium
                
            }
            
        }
    }
    

  
    

    

}
