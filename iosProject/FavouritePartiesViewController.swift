//
//  FavouritePartiesViewController.swift
//  iosProject
//
//  Created by Slim Karim on 16/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import CoreData

class FavouritePartiesViewController: UITableViewController {
    
  
    @IBOutlet weak var favoriteTableView: UITableView!
    var partieArray :[String] = []
    var partieArray2 :[String] = []
    var partieArray3 :[String] = []
    var partieArray4 :[String] = []
    var partieArray5 :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Favourites matchs ...")
      
        refreshControl.addTarget(self, action:  #selector(sortArray), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyParties")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                partieArray.append(data.value(forKey: "dateMatch") as! String)
           //     print("aaaa\(data.value(forKey: "heureMatch"))")
                partieArray2.append(data.value(forKey: "heureMatch") as! String)
                partieArray3.append(data.value(forKey: "equipe") as! String)
                partieArray4.append(data.value(forKey: "equipeA") as! String)
             //   partieArray5.append(data.value(forKey: "image") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
        tableView.tableFooterView = UIView()
    }
    @objc private func sortArray(_ sender: Any) {
  
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyParties")
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if partieArray.count == 0 {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "No Data"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
           // self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return 0
        } else {
            return partieArray.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartieCell")
        let partieLbl = cell?.viewWithTag(97) as? UILabel
        let partieLbl1 = cell?.viewWithTag(94) as? UILabel
        let partieLbl2 = cell?.viewWithTag(95) as? UILabel
        let partieLbl3 = cell?.viewWithTag(96) as? UILabel
   //      let partieLbl4 = cell?.viewWithTag(100) as? UIImageView
        partieLbl?.text = partieArray[indexPath.row]
        partieLbl1?.text = partieArray2[indexPath.row]
         partieLbl2?.text = partieArray3[indexPath.row]
         partieLbl3?.text = partieArray4[indexPath.row]

   //      partieLbl4?.image = UIImage(named: partieArray5[indexPath.row])
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            var myData: Array<AnyObject> = []
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyParties")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    myData.append(data)
                }
                
            } catch {
                
                print("Failed")
            }
            
            context.delete(myData[indexPath.row] as! NSManagedObject )
            myData.remove(at: indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            
            partieArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
    
}





