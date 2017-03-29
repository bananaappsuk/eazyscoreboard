//
//  MenuDetailViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 08/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//


import UIKit

class MenuDetailViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {

    // outlets 
    @IBOutlet weak var tableView : UITableView!
    
    // properties 
    var stringFromBeforeVC : String = ""
    var gameType = ["Rummy", "Scrabble", "UNO","Whist"]
    var calculationMode = ["Default", "Scores Add To Zero", "Winner takes it all","Highest Score"]
    var returnStringToSecondVC : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: table view delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stringFromBeforeVC == "Game Type"{
            return 4
        } else if stringFromBeforeVC == "Calculation Mode"{
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if stringFromBeforeVC == "Game Type"{
            cell.textLabel?.text = gameType[indexPath.row]
        } else if stringFromBeforeVC == "Calculation Mode"{
            cell.textLabel?.text = calculationMode[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        returnStringToSecondVC = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)

    }

    
    
}
