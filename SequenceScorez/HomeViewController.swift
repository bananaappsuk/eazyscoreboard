//
//  HomeViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 17/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit
import WCLShineButton
import SwiftyButton

class HomeViewController: UIViewController {

    @IBOutlet weak var btnRummy : PressableButton!
    @IBOutlet weak var btnSets : PressableButton!
    @IBOutlet weak var btnLux : PressableButton!
    @IBOutlet weak var btnSequence : PressableButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var param1 = WCLShineParams()
//        param1.bigShineColor = UIColor(rgb: (153,152,38))
//        param1.smallShineColor = UIColor(rgb: (102,102,102))
//        let yAxis : CGFloat = (self.view.frame.height-64)/2
//        let xAxis : CGFloat = self.view.frame.width/2
//        let bt1 = WCLShineButton(frame: .init(x: xAxis-40, y: yAxis-20, width: 60, height: 60), params: param1)
//        bt1.image  = WCLShineImage.custom(UIImage(named: "rummy")!)
//        bt1.fillColor = UIColor(rgb: (153,152,38))
//        bt1.color = UIColor(rgb: (170,170,170))
//        bt1.layer.borderColor =  UIColor.black.cgColor
//        bt1.addTarget(self, action: #selector(action), for: .touchUpInside)
//        view.addSubview(bt1)
        
        
        // adding colors to the pressable buttons 
        let cr = UIColor(colorLiteralRed: 250/255, green: 102/255, blue: 19/255, alpha: 1.0)
        btnRummy.colors = .init(button: cr, shadow: .lightGray)
        btnSets.colors = .init(button: cr, shadow: .lightGray)
        btnLux.colors = .init(button: cr, shadow: .lightGray)
        btnSequence.colors = .init(button: cr, shadow: .lightGray)

    }

  
    func action() -> Void {
        print("tapped")
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
