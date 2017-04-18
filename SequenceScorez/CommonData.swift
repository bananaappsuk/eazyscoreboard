//
//  CommonData.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 08/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

final class CommonData: NSObject {
    
    // can't init this class from outside
    private override init() {
      
    }
    
    //MARK: shared instance
  static let sharedInstance : CommonData = CommonData()

    
    
    //MARK: local variables
     var gameSelected : String = ""
     var playerNames :  [String : [String]] = [String : [String]]()
    
    var games : [String : [Game]] = ["games": []]
  //  var allDataOfAGameType : [String : [Game]] = [:]
    var data : [ String :     [ String : [Game] ]   ] = [:]
       //     { "sequence" :   { "games" : [game1, game2] }  }
    var sequenceData : [String : [Game]] = [String : [Game]]()
    
    
    
}


 /* 
 data -> [rummy,
            sets,
            lux,
            sequence]
 
 rummmy -> [ game1 ,
             game2 ,
             game3 ]
 
 game1 -> [  players : [player1,player2,player3]
             scores   : [player1score , player2score, player3score]
             isWinner : [false, true, false]
          ]
 
 */
