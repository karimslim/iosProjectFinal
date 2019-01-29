//
//  DetailEquipeController.swift
//  iosProject
//
//  Created by Slim Karim on 19/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class DetailEquipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var image = String()
    var nameEq = ""
    var nbPoint = ""
    var win = ""
    var continent = ""
    var draw = ""
    var butMarq = ""
    var butRecu = ""
    var idEquipe = String()
    var id_equipe = Int()
    
    
    
    @IBOutlet weak var JoueurTable: UITableView!
    @IBOutlet weak var equipeNamelbl: UILabel!
    @IBOutlet weak var continentlbl: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var butreculbl: UILabel!
    @IBOutlet weak var butmarqlbl: UILabel!
    @IBOutlet weak var defaitelbl: UILabel!
    @IBOutlet weak var ptslbl: UILabel!
    @IBOutlet weak var victoirelbl: UILabel!
    
    var joueursListe = [AnyObject]()
    let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/joueurs.php"
    
    @IBAction func backToDetail(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id_equipe = Int(idEquipe)!
        JoueurTable.delegate = self
        JoueurTable.dataSource = self
        let parameters: Parameters=["id": id_equipe]
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["joueurs"]{
                        
                        self.joueursListe = inner as! [AnyObject]
                        self.JoueurTable.reloadData()
                    }
                    
                    
                    
                }
                
        }
        
        imageview.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "coupedumonde"))
        equipeNamelbl.text! = nameEq
        continentlbl.text! = continent
        ptslbl.text! = nbPoint
        victoirelbl.text! = win
        defaitelbl.text! = draw
        butmarqlbl.text! = butMarq
        butreculbl.text! = butRecu
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JoueurTable.dequeueReusableCell(withIdentifier: "joueurCell") as! JoueurViewCell
        cell.joueurName.text =  joueursListe[indexPath.row]["nom_joueur"] as? String
        cell.posteJoueur.text =  joueursListe[indexPath.row]["poste"] as? String
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return joueursListe.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = UIStoryboard.init(name : "Main", bundle : nil).instantiateViewController(withIdentifier: "JoueurDetailController") as! JoueurDetailController
        desVC.nomJ = (joueursListe[indexPath.row]["nom_joueur"] as? String)!
        desVC.nationaliteJ = (joueursListe[indexPath.row]["nationalite"] as? String)!
        desVC.imgUrl = (joueursListe[indexPath.row]["photo_joueur"] as? String)!
        desVC.ageJ = (joueursListe[indexPath.row]["age"] as? String)!
        desVC.butJ = (joueursListe[indexPath.row]["nb_but"] as? String)!
        desVC.clubJ = (joueursListe[indexPath.row]["Club"] as? String)!
        desVC.posteJ = (joueursListe[indexPath.row]["poste"] as? String)!
        desVC.id_joueur = (joueursListe[indexPath.row]["id_joueur"] as? String)!
        desVC.id_equip = (joueursListe[indexPath.row]["id_equipe"] as? String)!
        
        
        
        
        self.present(desVC, animated: true, completion: nil)
    }
    
    
    
}
