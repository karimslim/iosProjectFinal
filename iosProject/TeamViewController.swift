//
//  TeamViewController.swift
//  iosProject
//
//  Created by Slim Karim on 15/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UISearchBarDelegate{
    var listofAfriqueTeams = [Team]()
    var listofEuropeTeams = [Team]()
    var listofAsieTeams = [Team]()
    var listofSouthTeams = [Team]()
    var listofCaribbeanTeams = [Team]()
    var currentTeam = [Team]()
    var currentTeam1 = [Team]()
    var currentTeam2 = [Team]()
    var currentTeam3 = [Team]()
    var currentTeam4 = [Team]()
    var TeamContinent = ["Europe", "Afrique", "Asie", "South America", "North And Central Caribbean"]
    @IBOutlet weak var tableListTeams: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpSearchBar()
        
        listofAfriqueTeams.append(Team(name: "Tunisie", coupeNumb: "0", image: "tun"))
        listofAfriqueTeams.append(Team(name: "Senegal", coupeNumb: "0" , image: "sen"))
        listofAfriqueTeams.append(Team(name: "Nigeria", coupeNumb: "0", image: "nga"))
        listofAfriqueTeams.append(Team(name: "Maroc", coupeNumb: "0", image: "mar"))
        listofEuropeTeams.append(Team(name: "Belgique", coupeNumb: "0" , image: "bel"))
        listofEuropeTeams.append(Team(name: "Croatie", coupeNumb: "0", image: "cro"))
        listofEuropeTeams.append(Team(name: "Denmark", coupeNumb: "0", image: "den"))
        listofEuropeTeams.append(Team(name: "England", coupeNumb: "1" , image: "eng"))
        listofEuropeTeams.append(Team(name: "France", coupeNumb: "1", image: "fra"))
        listofEuropeTeams.append(Team(name: "Germany", coupeNumb: "3", image: "ger"))
        listofEuropeTeams.append(Team(name: "Iceland", coupeNumb: "0" , image: "isl"))
        listofEuropeTeams.append(Team(name: "Pologne", coupeNumb: "0", image: "pol"))
        listofEuropeTeams.append(Team(name: "Portugal", coupeNumb: "0", image: "por"))
        listofEuropeTeams.append(Team(name: "Russia", coupeNumb: "0" , image: "rus"))
        listofEuropeTeams.append(Team(name: "Serbia", coupeNumb: "0", image: "srb"))
        listofEuropeTeams.append(Team(name: "Espagne", coupeNumb: "1", image: "esp"))
        listofEuropeTeams.append(Team(name: "Sweden", coupeNumb: "0" , image: "swe"))
        listofEuropeTeams.append(Team(name: "Suisse", coupeNumb: "0", image: "sui"))
        listofAsieTeams.append(Team(name: "Australie", coupeNumb: "0", image: "aus"))
        listofAsieTeams.append(Team(name: "Iran", coupeNumb: "0" , image: "irn"))
        listofAsieTeams.append(Team(name: "Japan", coupeNumb: "0", image: "jpn"))
        listofAsieTeams.append(Team(name: "Korea", coupeNumb: "0", image: "kor"))
        listofAsieTeams.append(Team(name: "Saudia Arabia", coupeNumb: "0" , image: "ksa"))
        listofSouthTeams.append(Team(name: "Argentina", coupeNumb: "2", image: "arg"))
        listofSouthTeams.append(Team(name: "Brazil", coupeNumb: "5", image: "bra"))
        listofSouthTeams.append(Team(name: "Colombie", coupeNumb: "0" , image: "col"))
        listofSouthTeams.append(Team(name: "Uruguay", coupeNumb: "2", image: "uru"))
        listofSouthTeams.append(Team(name: "Peru", coupeNumb: "0", image: "per"))
        listofCaribbeanTeams.append(Team(name: "Panama", coupeNumb: "0" , image: "pan"))
        listofCaribbeanTeams.append(Team(name: "Mexique", coupeNumb: "0", image: "mex"))
        listofCaribbeanTeams.append(Team(name: "Costa Rica", coupeNumb: "0", image: "crc"))
        
        
        tableListTeams.delegate = self
        tableListTeams.dataSource = self
        currentTeam = listofEuropeTeams
        currentTeam1 = listofAfriqueTeams
        currentTeam2 = listofAsieTeams
        currentTeam3 = listofSouthTeams
        currentTeam4 = listofCaribbeanTeams
    }
    
    private func SetUpSearchBar(){
        searchBar.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TeamContinent[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return currentTeam.count
        } else if section == 1 {
            return currentTeam1.count
        } else if section == 2 {
            return currentTeam2.count
        } else if section == 3 {
            return currentTeam3.count
        } else {
            return currentTeam4.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTeam:CustomTeamCell = tableView.dequeueReusableCell(withIdentifier: "cellTeam", for: indexPath) as! CustomTeamCell
        if indexPath.section == 0 {
            cellTeam.SetTeam(team: currentTeam[indexPath.row])
        } else if indexPath.section == 1{
            cellTeam.SetTeam(team: currentTeam1[indexPath.row])
        } else if indexPath.section == 2 {
            cellTeam.SetTeam(team: currentTeam2[indexPath.row])
        } else if indexPath.section == 3 {
            cellTeam.SetTeam(team: currentTeam3[indexPath.row])
        } else {
            cellTeam.SetTeam(team: currentTeam4[indexPath.row])
        }
        
        return cellTeam
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentTeam = listofEuropeTeams;
            currentTeam1 = listofAfriqueTeams;
            currentTeam2 = listofAsieTeams;
            currentTeam3 = listofSouthTeams;
            currentTeam4 = listofCaribbeanTeams;
            tableListTeams.reloadData()
            return
            
        }
        currentTeam = listofEuropeTeams.filter({ team -> Bool in
            
            return team.name!.contains(searchText)
        })
        currentTeam1 = listofAfriqueTeams.filter({ team -> Bool in
            
            return team.name!.contains(searchText)
        })
        currentTeam2 = listofAsieTeams.filter({ team -> Bool in
            
            return team.name!.contains(searchText)
        })
        currentTeam3 = listofSouthTeams.filter({ team -> Bool in
            
            return team.name!.contains(searchText)
        })
        currentTeam4 = listofCaribbeanTeams.filter({ team -> Bool in
            
            return team.name!.contains(searchText)
        })
        tableListTeams.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}

