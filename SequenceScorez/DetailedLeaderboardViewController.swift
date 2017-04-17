//
//  DetailedLeaderboardViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 06/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class DetailedLeaderboardViewController: UIViewController , UITabBarDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!

    var gameSelected : String = ""
    var playerNmaes : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // if there are player names for this game please load into the local variable 
        print(playerNmaes)
        
    }

    // MARK: table view delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNmaes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DetailLeaderboardTableViewCell
        let playerName = playerNmaes[indexPath.row]
        cell?.configureCell(gameName :gameSelected,playerName : playerName)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    



}
