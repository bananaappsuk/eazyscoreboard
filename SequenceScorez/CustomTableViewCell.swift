//
//  CustomTableViewCell.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 05/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

// protocol for delgating to secondviewcontroller

protocol changePictureProtocol : NSObjectProtocol {
    func loadNewScreen (cellIndex cellTag : Int) -> ()
}


class CustomTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // outlets 
    @IBOutlet weak var imgViewPlayer : UIImageView!
    @IBOutlet weak var lblPlayerName : UILabel!

    // delegate property
    weak var delegate: changePictureProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        imgViewPlayer.isUserInteractionEnabled = true
        imgViewPlayer.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func imageTapped(img: AnyObject)
    {
        self.delegate?.loadNewScreen(cellIndex: self.tag)
    }

}
