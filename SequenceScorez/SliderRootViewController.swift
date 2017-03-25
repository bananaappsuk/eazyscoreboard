//
//  SliderRootViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 04/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class SliderRootViewController: SlideMenuController {

    
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "navigVC") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "leftVC") {
            self.leftViewController = controller
            
        }
        super.awakeFromNib()
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

    
    // this comment is added only to second commit 
    
}
