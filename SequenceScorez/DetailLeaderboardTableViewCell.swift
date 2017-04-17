//
//  DetailLeaderboardTableViewCell.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 06/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class DetailLeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPlayerName : UILabel!
    @IBOutlet weak var lblScoreName : UILabel!
    @IBOutlet weak var lblScoreValue : UILabel!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(gameName: String ,playerName : String ) -> () {
        lblPlayerName.text = playerName
    }

}
