//
//  Game.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 18/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import Foundation
import UIKit


class Game: NSObject {
    
    var players : [String] = []
    var playerImages : [[String : UIImage]] = []
    var scores  : [Double] = []
    var isWinner : [Bool]  = []
    
    init(players : [String]) {
        self.players = players
         playerImages = []
         scores  = []
         isWinner = []
        
    }
    
}
