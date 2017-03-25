//
//  ScoreViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 08/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITextFieldDelegate {
    
    
    var yAxis :  CGFloat = 135 + 10
    var yAxisPositionDecider : Int = 0
    
    var scrollVw : UIScrollView = UIScrollView()
    var totalLabelsArray = [UILabel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true

    }

   
    override func awakeFromNib() {
     let k = CommonData.gameSelected
        if let total = CommonData.playerNames[k]?.count {
             scrollVw = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            scrollVw.isUserInteractionEnabled = true
            scrollVw.contentSize = CGSize(width: CGFloat(40 + (75*total) + (10*total-1)), height: self.view.frame.height-64)
            self.view.addSubview(scrollVw)
    
            
            for i in 0..<total {
               let y = CGFloat(20)
                let imageVw = UIImageView(frame: CGRect(x: 20+i*75+10*i, y: Int(y), width: 75, height: 75))
                imageVw.image = UIImage(named : "cardsbg.jpg")
                //  first check if there is a user photo in the disk
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                if (CommonData.playerNames[CommonData.gameSelected]?.count)! > 0 {
                    let filePath = paths[0] + "/" + (CommonData.playerNames[CommonData.gameSelected]?[i])! + ".png"
                    let dataOfPhoto = NSData(contentsOfFile: filePath)
                    if dataOfPhoto != nil {
                        let image = UIImage(data: dataOfPhoto as! Data)
                        if image != nil {
                            imageVw.image = image
                        }
                    } else {
                        imageVw.image = UIImage(named: "defaultplayer.png")
                    }
                }
                
                scrollVw.addSubview(imageVw)
                
                let lblTotal : UILabel = UILabel(frame: CGRect(x: 20+i*75+10*i, y: Int(y + 75 + 10), width: 75, height: 30))
                lblTotal.tag = i
                lblTotal.text = "0"
                lblTotal.textAlignment = .center
                totalLabelsArray.append(lblTotal)
                scrollVw.addSubview(lblTotal)
   
            }
            
        }
     
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
   
    @IBAction func addScore() {
        yAxisPositionDecider = yAxisPositionDecider + 1
        let k = CommonData.gameSelected
        if let total = CommonData.playerNames[k]?.count {
      //      yAxis = 20 + 75 + ( 20 * CGFloat(yAxisPositionDecider) )
            yAxis = yAxis + 1
            for i in 0..<total {
                let txtField = UITextField(frame: CGRect(x: 20+i*75+10*i, y: Int(yAxis), width: 75, height: 40))
                txtField.tag = i
                txtField.delegate = self
                txtField.keyboardType = UIKeyboardType.decimalPad
                txtField.returnKeyType = UIReturnKeyType.done
                txtField.textAlignment = NSTextAlignment.center
                txtField.layer.borderWidth = 1
                txtField.layer.borderColor = UIColor.lightGray.cgColor
                let toolbar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 44)))
                toolbar.items = [
                    UIBarButtonItem(barButtonSystemItem: .done, target: txtField,
                                    action: #selector(resignFirstResponder))
                ]
                txtField.inputAccessoryView = toolbar
                scrollVw.addSubview(txtField)
                }
            yAxis = yAxis + 40
            
        }
        
        
        
    }
    
    
    // textfield delegate methods 
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.returnKeyType = UIReturnKeyType.done
        var textEnteredInTextField : String = "0"
        if let txtEntered = textField.text {
            textEnteredInTextField = txtEntered
        }
        
        let tagValue = textField.tag
        
        for (index,lbl) in totalLabelsArray.enumerated() {
            
            if lbl.tag == tagValue {
                
                let previousSum = Int(lbl.text!)
                if let previousSumValue = previousSum {
                    if let intConverted = Int(textEnteredInTextField) {
                        let newSum = previousSumValue + intConverted
                        lbl.text = "\(newSum)"
                    } else {
                        let newSum = previousSumValue
                        lbl.text = "\(newSum)"
                    }
                  
                }
                
            }
            
        }
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // here we will find if any value already exists in the textfield we will convert it to int and remove from the sum 
        textField.returnKeyType = UIReturnKeyType.done
        var textEnteredInTextField : String = "0"
        if let txtEntered = textField.text {
            textEnteredInTextField = txtEntered
        }
        let tagValue = textField.tag
        for (index,lbl) in totalLabelsArray.enumerated() {
            if lbl.tag == tagValue {
                let previousSum = Int(lbl.text!)
                if let previousSumValue = previousSum {
                    if let intConverted = Int(textEnteredInTextField) {
                        let newSum = previousSumValue - intConverted
                        lbl.text = "\(newSum)"
                    } else {
                        let newSum = previousSumValue
                        lbl.text = "\(newSum)"
                    }
                    
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("inside the touches began")
        
        self.view.endEditing(true)
    }

}
