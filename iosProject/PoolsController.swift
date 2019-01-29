//
//  PoolsController.swift
//  iosProject
//
//  Created by Slim Karim on 25/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class PoolsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedSegment = 1
    let array1 = ["Tunisie","Cameroun","Bresil","Belgique"]
    let array2 = ["Arabie Saoudite","Angleterre","Egypte","Panama"]
    let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/groupe1.php"
 
     var G1Liste = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: nil).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["groupe1"]{
                        
                        self.G1Liste = inner as! [AnyObject]
                        self.groupTableView.reloadData()
                    }
                    
                    
                    
                }
                
                
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func groupsControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
            selectPool(id: selectedSegment)
        } else if sender.selectedSegmentIndex == 1{
            selectedSegment = 2
            selectPool(id: selectedSegment)
        } else if sender.selectedSegmentIndex == 2{
            selectedSegment = 3
            selectPool(id: selectedSegment)
        } else if sender.selectedSegmentIndex == 3{
            selectedSegment = 4
            selectPool(id: selectedSegment)
        } else if sender.selectedSegmentIndex == 4{
            selectedSegment = 5
            selectPool(id: selectedSegment)
        }
        else if sender.selectedSegmentIndex == 5{
            selectedSegment = 6
            selectPool(id: selectedSegment)
        } else if sender.selectedSegmentIndex == 6{
            selectedSegment = 7
            selectPool(id: selectedSegment)
        }
        else if sender.selectedSegmentIndex == 7{
            selectedSegment = 8
            selectPool(id: selectedSegment)
        }
        self.groupTableView.reloadData()
        
    }
    @IBOutlet weak var groupTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "teamCell") as! PoolsCell
       
      
            cell.EquipeImg.sd_setImage(with: URL(string: (G1Liste[indexPath.row]["drapeau_equipe"] as? String)!), placeholderImage: UIImage(named: "coupedumonde"))
       // cell.EquipeImg.layer.cornerRadius = cell.EquipeImg.frame.height / 2
        // cell.EquipeImg.layer.cornerRadius = 50
        
        
            cell.EquipeName.text = G1Liste[indexPath.row]["nom_equipe"] as? String
            cell.EquipPts.text = G1Liste[indexPath.row]["nb_point"] as? String

            return cell
       
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return G1Liste.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = UIStoryboard.init(name : "Main", bundle : nil).instantiateViewController(withIdentifier: "DetailEquipeController") as! DetailEquipeController
        desVC.idEquipe = (G1Liste[indexPath.row]["id_equipe"] as? String)!
        desVC.continent = (G1Liste[indexPath.row]["continent"] as? String)!
        desVC.image = (G1Liste[indexPath.row]["drapeau_equipe"] as? String)!
        desVC.nameEq = (G1Liste[indexPath.row]["nom_equipe"] as? String)!
        desVC.nbPoint = (G1Liste[indexPath.row]["nb_point"] as? String)!
        desVC.butMarq = (G1Liste[indexPath.row]["but_marque"] as? String)!
        desVC.butRecu = (G1Liste[indexPath.row]["but_recu"] as? String)!
        desVC.win = (G1Liste[indexPath.row]["nb_victoire"] as? String)!
        desVC.draw = (G1Liste[indexPath.row]["nb_defaite"] as? String)!
        
        self.present(desVC, animated: true, completion: nil)
        
    }
  
    func selectPool(id : Int){
        let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/pools.php"
        let parameters: Parameters=["id": id]
      
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["groupe1"]{
                        
                        self.G1Liste = inner as! [AnyObject]
                        self.groupTableView.reloadData()
                    }
                    
                    
                    
                }
                
                
        }
        
    }

  

}
