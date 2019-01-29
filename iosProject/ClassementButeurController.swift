

import UIKit
import Alamofire

class ClassementButeurController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedSegment = 1
    @IBOutlet weak var buteurTable: UITableView!
    let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/joueurParBut.php"
    
    var buteurListe = [AnyObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buteurTable.delegate = self
        buteurTable.dataSource = self
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: nil).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["joueurs"]{
                        
                        self.buteurListe = inner as! [AnyObject]
                        self.buteurTable.reloadData()
                    }
                }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = buteurTable.dequeueReusableCell(withIdentifier: "buteurCell") as! ButeurViewCell
        
        
        cell.nomButeur.text = buteurListe[indexPath.row]["nom_joueur"] as? String
        cell.clubButeur.text = buteurListe[indexPath.row]["Club"] as? String
        if selectedSegment == 1 {
            cell.nombreButButeur.text = (buteurListe[indexPath.row]["nb_but"] as? String)!+" Goals"
            
        }else {
            cell.nombreButButeur.text = (buteurListe[indexPath.row]["nb_but"] as? String)!+" /10"
            
        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buteurListe.count
    }
    @IBAction func SegmentedValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
            selectButeur()
        } else if sender.selectedSegmentIndex == 1{
            selectedSegment = 2
            selectRating()
        }
        self.buteurTable.reloadData()
    }
    func selectRating(){
        let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/ratingJoueur.php"
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: nil).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["ratings"]{
                        
                        self.buteurListe = inner as! [AnyObject]
                        self.buteurTable.reloadData()
                    }
                }
                
                
        }
        
    }
    func selectButeur(){
        let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/joueurParBut.php"
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: nil).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["joueurs"]{
                        
                        self.buteurListe = inner as! [AnyObject]
                        self.buteurTable.reloadData()
                    }
                }
                
                
        }
        
    }
    
    
    
}
