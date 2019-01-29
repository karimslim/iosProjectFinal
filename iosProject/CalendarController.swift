//
//  CalendarController.swift
//  iosProject
//
//  Created by Slim Karim on 25/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//
import UIKit
import SDWebImage
import  Alamofire
import CoreData

class CalendarController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
   
    @IBOutlet weak var imge: UIImageViewX!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var calenderTableView: UITableView!
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    var G1Liste = [AnyObject]()
    let userCalendar = Calendar.current
    var selectedSegment = 1
    let requestedComponent: Set<Calendar.Component> = [.day,.hour,.minute,.second]
    var favArray : [String] = []
    var  dateMatch = ""
    var  heureMatch = ""
    var  equipe1 = ""
    var equipe2 = ""
    var selectedMatch = ""
    let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/teams.php"
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       imge.addBlur()
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        timer.fire()
       let parameters: Parameters=["id": 1]
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                
                //getting the user from response
                if let groups = result.value as? Dictionary<String,AnyObject>{
                    if let inner=groups["matchs"]{
                        
                        self.G1Liste = inner as! [AnyObject]
                        self.calenderTableView.reloadData()
                    }
                    
                    
                    
                }
                
                
        }
        
        
        
        
    }
    
    @objc func printTime()
    {
        dateFormatter.dateFormat = "dd/MM/yy hh:mm:ss"
        let startTime = Date()
        let endTime = dateFormatter.date(from: "14/06/2018 00:4:00")
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime, to: endTime!)
        
       dateLabelOutlet.text = "\(timeDifference.day!)"
        hourLabel.text = "\(timeDifference.hour!)"
        minLabel.text = "\(timeDifference.minute!)"
        secLabel.text = "\(timeDifference.second!)"
    }
    
    
    
    
    @IBAction func segmentedJourneeController(_ sender: UISegmentedControl) {
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
        self.calenderTableView.reloadData()
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calenderTableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CustonCalendarCell
        //  cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.eq1.layer.cornerRadius = cell.eq1.frame.height / 2
        cell.eq2.layer.cornerRadius = cell.eq2.frame.height / 2
        
        
        cell.eq1.sd_setImage(with: URL(string: (G1Liste[indexPath.row]["drapeau1"] as? String)!))
        cell.eq2.sd_setImage(with: URL(string: (G1Liste[indexPath.row]["drapeau2"] as? String)!))
        cell.stadeName.text = G1Liste[indexPath.row]["date_match"] as? String
        cell.nameeq1.text = G1Liste[indexPath.row]["equipe1"] as? String
        cell.nameeq2.text = G1Liste[indexPath.row]["equipe2"] as? String
        cell.heureMatch.text = G1Liste[indexPath.row]["heure_match"] as? String
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return G1Liste.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailMatch"{
            if let controller = segue.destination as? DetailControllerViewController,
                let indexPath = calenderTableView.indexPathForSelectedRow {
                controller.image = (G1Liste[indexPath.row]["drapeau1"] as? String)!
                controller.imageEquipe = (G1Liste[indexPath.row]["drapeau2"] as? String)!
                controller.labelDate = (G1Liste[indexPath.row]["date_match"] as? String)!
                controller.labelHeure = (G1Liste[indexPath.row]["heure_match"] as? String)!
                controller.labelEq1 = (G1Liste[indexPath.row]["equipe1"] as? String)!
                controller.labelEq2 = (G1Liste[indexPath.row]["equipe2"] as? String)!
                controller.labelStade = (G1Liste[indexPath.row]["stades"] as? String)!
                
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMatch = (G1Liste[indexPath.row]["date_match"] as? String)!
        performSegue(withIdentifier: "toDetailMatch", sender: nil)
    }
    
    
    func selectPool(id : Int){
        let URL_USER_LOGIN = String(AppDelegate.adresseIP)+"AndroidBD/teams.php"
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
                    if let inner=groups["matchs"]{
                        
                        self.G1Liste = inner as! [AnyObject]
                        self.calenderTableView.reloadData()
                    }
                    
                    
                    
                }
                
                
        }
        
    }
    
}



protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.75) {
        // create effect
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

extension UIView: Bluring {}




