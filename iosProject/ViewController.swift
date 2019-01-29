//
//  ViewController.swift
//  iosProject
//
//  Created by Slim Karim on 25/03/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var actualityTable: UITableView!
    
    var articles: [Actuality] = []
    let actualityArray 	= ["bresil", "tunisie", "argentine", "marroc"]
   // let URL_USER_LOGIN = "http://197.28.182.5/AndroidBD/actualities.php"
    
    var actualityListe = [AnyObject]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualityTable.dataSource = self
        actualityTable.delegate = self
        super.viewDidLoad()
        fetchActualities()
     
    }
  
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = actualityTable.dequeueReusableCell(withIdentifier: "actualityCell") as! ActualityCell
        //    cell.layer.cornerRadius = 50
        //cell.imageCell.image = UIImage(named: (actualityListe[indexPath.row]["image"] as? String)!)
        //cell.imageCell.sd_setImage(with: URL(string: (actualityListe[indexPath.row]["image"] as? String)!), placeholderImage: UIImage(named: "tunisie"))
        // cell.titleCell.text = actualityArray[indexPath.row].capitalized
        
      
        // cell.titleCell.text = actualityListe[indexPath.row]["nom"] as? String
        
        cell.titleCell.text = articles[indexPath.item].title
          //cell.imageCell.sd_setImage(with: URL(string: (articles[indexPath.row].urlImg)!), placeholderImage: UIImage(named: "tunisie"))
        
        if  self.articles[indexPath.item].urlImg == nil {
            cell.imageCell.image = UIImage(named : "coupedumonde")
        } else {
             cell.imageCell.downloadImage(from: self.articles[indexPath.item].urlImg!)
        }
      
        
        
        return cell
       
            }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return articles.count
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LoadingOverlay.shared.showProgressView(view)
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "DetailsActualityController") as! DetailsActualityController
        
        //desVC.image = UIImage(named: actualityListe[indexPath.row])!
        desVC.image = (articles[indexPath.item].urlImg)!
        desVC.titleAc = articles[indexPath.item].title!
        desVC.descAc = articles[indexPath.item].desc!
        
        
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    func fetchActualities(){
        let urlRequest = URLRequest(url: URL(string : "https://newsapi.org/v2/top-headlines?sources=football-italia&apiKey=373fd1b74aeb471cadc2e0354d2ae79d")!)
        LoadingOverlay.shared.showProgressView(view)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            if error != nil {
                print(error!)
            }
            self.articles = [Actuality]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let actualitiesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for actualityFromJson in actualitiesFromJson {
                        let actuality = Actuality()
                        if let title = actualityFromJson["title"] as? String, let desc = actualityFromJson["description"] as? String,
                            let url = actualityFromJson["url"] as? String, let urlImage = actualityFromJson["urlToImage"] as? String {
                            actuality.title = title
                            actuality.desc = desc
                            actuality.url = url
                            actuality.urlImg = urlImage
             
                        }
                        self.articles.append(actuality)
                    }
                }
               
                DispatchQueue.main.sync {
                     LoadingOverlay.shared.hideProgressView()
                    self.actualityTable.reloadData()
                }
                
                
            } catch let error{
                print(error)
            }
        
        }
        task.resume()
        }
        
    }
extension UIImageView {
    func downloadImage(from url : String){
        let urlRequest = URLRequest(url : URL(string : url)!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            if error != nil {
                print(error!)
              return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
                
            }
        }
        task.resume()
        
    }
}
    






