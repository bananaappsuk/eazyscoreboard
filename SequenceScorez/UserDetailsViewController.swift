//
//  UserDetailsViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 17/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    
    @IBOutlet weak var txtFieldName : UITextField!
    @IBOutlet weak var imageViewUserPic : UIImageView!

    
    
    
    @IBAction func backToNewGameVC (sender : UIButton) {
      _ =  navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveUserDetailsToDisk(sender : UIButton) {
        // save the details to the Model class
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
