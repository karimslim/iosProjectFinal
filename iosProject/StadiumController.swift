//
//  StadiumController.swift
//  iosProject
//
//  Created by Slim Karim on 25/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class StadiumController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var stadiumCollectionView: UICollectionView!
    let stadiumArray = ["stadium1", "stadium2", "stadium3"]
    let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/stades.php"
    var stadiumListe = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showProgressView(view)
        let delay = max(0.0, 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            LoadingOverlay.shared.hideProgressView()
            
        }
        stadiumCollectionView.delegate = self
        stadiumCollectionView.dataSource = self
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: nil).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let actualities = result.value as? Dictionary<String,AnyObject>{
                    if let inner=actualities["stadiums"]{
                        
                        self.stadiumListe = inner as! [AnyObject]
                        self.stadiumCollectionView.reloadData()
                    }
                    
                    
                    
                }
                
                
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stadiumListe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stadiumCollectionView.dequeueReusableCell(withReuseIdentifier: "stadiumCell", for: indexPath) as! CustomStadiumCell
        
        cell.stadiumImage.sd_setImage(with: URL(string: (stadiumListe[indexPath.row]["image"] as? String)!), placeholderImage: UIImage(named: "coupedumonde"))
        cell.stadiumName.text = stadiumListe[indexPath.row]["nom_stade"] as? String
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "MapStadiumController") as! MapStadiumController
        desVC.image = (stadiumListe[indexPath.row]["image"] as? String)!
        desVC.titleStadium = (stadiumListe[indexPath.row]["nom_stade"] as? String)!
        desVC.descStadium = (stadiumListe[indexPath.row]["description"] as? String)!
        desVC.capaciteStadium = (stadiumListe[indexPath.row]["nombre_spec"] as? String)!
        desVC.equipeStadium = (stadiumListe[indexPath.row]["equipe_res"] as? String)!
        desVC.longitude = (stadiumListe[indexPath.row]["longitude"] as? String)!
        desVC.latitude = (stadiumListe[indexPath.row]["latitude"] as? String)!
        self.navigationController?.pushViewController(desVC, animated: true)
        
        
    }
    



}
