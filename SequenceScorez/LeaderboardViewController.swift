//
//  LeaderboardViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 04/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    
    // properties 
    @IBOutlet weak var tableView : UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

 
    
    // MARK: table view delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstViewController.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = FirstViewController.menus[indexPath.row]
        if let timestamps = CommonData.playerNames["timestamp"]?.first {
            cell.detailTextLabel?.text = timestamps
        } else {
            cell.detailTextLabel?.text = ""
        }
        // we have to get the time stamps of when the game is closed and display along with the name
        
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width)!/2
        cell.imageView?.clipsToBounds = true
        cell.imageView?.image = UIImage(named: "gameimage.png")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier ==  "toDetail" {
        
            if let dvc = segue.destination as? DetailedLeaderboardViewController, let game = (sender as? UITableViewCell)?.textLabel?.text , let playerNames = CommonData.playerNames[game] {
                  dvc.gameSelected = game
                  dvc.playerNmaes = playerNames
            }
        }
        
        
        
        
    }
    

}
