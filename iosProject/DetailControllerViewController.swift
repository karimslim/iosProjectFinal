//
//  DetailControllerViewController.swift
//  iosProject
//
//  Created by Slim Karim on 04/05/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import UserNotifications

class DetailControllerViewController: UIViewController {
    
    
    var favArray : [String] = []
    var image = String()
    var imageEquipe = String()
    var labelDate = String()
    var labelHeure = String()
    var labelEq1 = String()
    var labelEq2 = String()
    var labelStade = String()
    let now = Date()
    let start = "2018-05-14 02:43:20"
    
    
    let dateFormatter = DateFormatter()
    
    
  
    
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var favouriteView: UIViewX!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var imgEq: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var addFavorisButton: UIButton!
    @IBOutlet weak var favButton: UIButtonX!
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil {
                print("Authorization Unsuccessful")
            } else {
                print("Authorization Successful" )
            }
        }
      
        favButton.alpha = 0
        img.sd_setImage(with: URL(string: (image)))
        // img.image = UIImage(named: image)
        //   imgEq.image = UIImage(named: imageEquipe)
        //     imgEq.sd_setImage(with: URL(string: (imageEquipe)))
        imgEq.sd_setImage(with: URL(string: (imageEquipe)))
        lbl1.text = labelDate
        lbl2.text = labelHeure
        lbl3.text = labelEq1
        lbl4.text = labelEq2
        lbl6.text = labelStade
        loadFav()
     
        
       
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        if favouriteView.transform == .identity{
            UIView.animate(withDuration: 1, animations: {
                self.favouriteView.transform = CGAffineTransform(scaleX: 11, y: 11)
                self.menuView.transform = CGAffineTransform(translationX: 0, y: -11)
                self.addFavorisButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees: 180))
            }) { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.toggleSharedButton()
                })
            }
        } else {
            UIView.animate(withDuration: 1, animations: {
                self.favouriteView.transform = .identity
                self.menuView.transform = .identity
                self.addFavorisButton.transform = .identity
                self.toggleSharedButton()
            })
        }
    }
    
    func toggleSharedButton(){
        let alpha = CGFloat(favButton.alpha == 0 ? 1 : 0)
        favButton.alpha = alpha
    }
    
    func radians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / degrees)
    }
    
    @IBAction func favActionButton(_ sender: UIButtonX) {
     
            timedNotifications(inSeconds: 5) { (success) in
                if success  {
                    print("Successfully Notified")
                }
            }
            
        
        
        
        
        
        if !favArray.contains(labelDate) && !favArray.contains(labelEq1) {
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "MyParties", in: managedContext)
            let partie = NSManagedObject(entity: entity!, insertInto: managedContext)
            print(labelHeure,"fefe")
            partie.setValue(labelDate, forKey: "dateMatch")
            partie.setValue(labelHeure, forKey: "heureMatch")
            partie.setValue(labelEq1, forKey: "equipe")
            partie.setValue(labelEq2, forKey: "equipeA")
           // partie.setValue(imageEquipe, forKey: "image")
            
            do {
                try managedContext.save()
                let alert = UIAlertController(title: "Success", message: "Partie Added", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                loadFav()
                print("ok")
            } catch {
                print("failed =(")
            }
        } else {
            let alert = UIAlertController(title: "Warning", message: "Partie Already Exists", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadFav(){
        favArray.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyParties")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                favArray.append((data.value(forKey: "dateMatch") as! String))
               // favArray.append((data.value(forKey: "equipe") as! String))
               
            }
            
        } catch {
            
            print("Failed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        
        content.title = labelDate
        content.subtitle = labelHeure
        content.body = labelEq1+" "+"VS"+" "+labelEq2
        content.sound = UNNotificationSound.default()
       
        if let path = Bundle.main.path(forResource: "messi", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "messi", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
       
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}







