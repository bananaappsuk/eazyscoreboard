//
//  GameListViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 18/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {
    
    
    var newGame : Game = Game(players: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    

   
    @IBAction func createANewGame(sender : UIButton) {
        // create an instance of a Game Class and set its properties to defaults 
        if CommonData.sharedInstance.data[CommonData.sharedInstance.gameSelected]?["games"] == nil {
            print("sfasfasfsafsaf")
            let initialGamesArray = [newGame]
            let initialData = ["games" : initialGamesArray]
            CommonData.sharedInstance.data[CommonData.sharedInstance.gameSelected] = initialData
        } else {
            CommonData.sharedInstance.data[CommonData.sharedInstance.gameSelected]?["games"]?.append(newGame)
        }
        
        performSegue(withIdentifier: "toNewGameVC", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toNewGameVC" {
            _ = segue.destination as? NewGameViewController
        }
    }
    

}
