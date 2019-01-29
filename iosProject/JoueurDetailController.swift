

import UIKit
import SDWebImage
import Alamofire

class JoueurDetailController: UIViewController {
    
    var nomJ = ""
    var nationaliteJ = ""
    var ageJ = ""
    var posteJ = ""
    var butJ = ""
    var clubJ = ""
    var imgUrl = ""
    var id_joueur = ""
    var id = Int()
    var id_equip = String()
    
    
    
    
    
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var joueurName: UILabel!
    
    @IBOutlet weak var joueurNationalite: UILabel!
    
    @IBOutlet weak var joueurAge: UILabel!
    
    @IBOutlet weak var joueurPoste: UILabel!
    @IBOutlet weak var joueurNbBut: UILabel!
    @IBOutlet weak var joueurClub: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    var ratingValue = Int()
    
    @IBOutlet weak var submitRating: UIButton!
    @IBAction func AlerteRating(_ sender: UIButton) {
        var msg = "Are you sure to rate  "
        msg += nomJ
        msg += " "+String(ratingValue)
        msg += "/10"
        RatePlayer()
        let alerteController = UIAlertController(
            title : "Rating",
            message : msg,
            preferredStyle : .alert
        )
        
        let imageAlerte = UIImage(named : "review")
        
        
        alerteController.addImage(image : imageAlerte!)
        
        let okAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let desVC = UIStoryboard.init(name : "Main", bundle : nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            self.present(desVC, animated: true, completion: nil)
            
        }
        alerteController.addAction(okAction)
        // alerteController.addAction(UIAlertAction(title : "Submit", style : .default, handler: nil))
        self.present(alerteController, animated: true, completion: nil)
        
    }
    @IBAction func sliderRating(_ sender: UISlider) {
        lblRating.text = String(Int(sender.value))
        ratingValue = Int(sender.value)
        
    }
    @IBAction func submitRating(_ sender: UIButton) {
        RatePlayer()
        
        
        
    }
    
    @IBAction func toDetailEq(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayer"{
            let alert = UIAlertController(title: "Rating", message: "Success", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            // alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let desVC = UIStoryboard.init(name : "Main", bundle : nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                self.present(desVC, animated: true, completion: nil)
                
            }
            alert.addAction(okAction)
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showProgressView(view)
        let delay = max(0.0, 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            LoadingOverlay.shared.hideProgressView()
            
        }
        id = Int(id_joueur)!
        
        imagePlayer.sd_setImage(with: URL(string: (imgUrl)), placeholderImage: UIImage(named: "coupedumonde"))
        //equipeNamelbl.text! = nameEq
        joueurName.text! = nomJ
        joueurNationalite.text! = nationaliteJ
        joueurAge.text! = ageJ
        joueurPoste.text! = posteJ
        joueurNbBut.text! = butJ+" Goals"
        joueurClub.text! = clubJ
        
        
        
        
    }
    
    func RatePlayer(){
        let parameters: Parameters = [
            "id_joueur": id,
            "note": ratingValue
        ]
        let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/ratePlayer.php"
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
            print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "My Title", message: "failed", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            
            
        }
        
    }
    
    
    
}

