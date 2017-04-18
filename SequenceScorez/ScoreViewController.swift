
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
    
    var activeField : UITextField = UITextField()
    var maxTotalGameScore : String?
    var initialDropScore  : String?
    var middleDropScore   : String?
    var maxScorePerGame   : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        registerForKeyboardNotifications()
    }

   
    override func awakeFromNib() {
              // as we came here let us make a copy of the players in the CommonData.playerNames dictionary with key "copyOfPlayerNames" as key
        let tempForPlayerNames = CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]
        CommonData.sharedInstance.playerNames["copyOfPlayerNames"] = tempForPlayerNames
        
     let k = CommonData.sharedInstance.gameSelected
        if let total = CommonData.sharedInstance.playerNames[k]?.count {
             scrollVw = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            scrollVw.isUserInteractionEnabled = true
            scrollVw.contentSize = CGSize(width: CGFloat(40 + (75*total) + (10*total-1)), height: self.view.frame.height-64)
            self.view.addSubview(scrollVw)
    
            // this is for initializing the array with false
            let str = CommonData.sharedInstance.gameSelected
            let keyString = str + "boolArrayForDeletedPlayers"
            var tempArray : [String] = []
            for  _ in 0..<total {
                tempArray.append("not")
            }
            CommonData.sharedInstance.playerNames[keyString] = tempArray
            print("bool for player names \(CommonData.sharedInstance.playerNames[keyString])")
            
            for i in 0..<total {
               let y = CGFloat(20)
                let imageVw = UIImageView(frame: CGRect(x: 20+i*75+10*i, y: Int(y), width: 75, height: 75))
                imageVw.image = UIImage(named : "cardsbg.jpg")
                //  first check if there is a user photo in the disk
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                if (CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?.count)! > 0 {
                    let filePath = paths[0] + "/" + (CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?[i])! + ".png"
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
        let k = CommonData.sharedInstance.gameSelected
        if let total = CommonData.sharedInstance.playerNames[k]?.count {
      //      yAxis = 20 + 75 + ( 20 * CGFloat(yAxisPositionDecider) )
            yAxis = yAxis + 1
            
            // this is to show that the left one player is the winner
           
            var tempForTotalLabelNames = self.totalLabelsArray

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
                if let totalScoreOfPlayerUptoNowToMarkYellow = totalLabelsArray[i].text {
                    let sumInInt = Double(totalScoreOfPlayerUptoNowToMarkYellow)
                    if let totalSumAllowedInInt = Double(self.maxTotalGameScore!) {
                    if sumInInt! >= totalSumAllowedInInt {
                        txtField.backgroundColor = UIColor.black
                        txtField.removeFromSuperview()
                        totalLabelsArray[i].backgroundColor = UIColor.black
                        totalLabelsArray[i].textColor = UIColor.white
                        let str = CommonData.sharedInstance.gameSelected
                        let keyString = str + "boolArrayForDeletedPlayers"
                        if CommonData.sharedInstance.playerNames[keyString]![i] == "not" {
                        let alertMessage = UIAlertController(title: "\((CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?[i])!) lost", message: "Do you want to add  \((CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?[i])!) again", preferredStyle: .alert)
                        
                        alertMessage.addTextField(configurationHandler: { (txtField) in
                            txtField.placeholder = "Score here"
                        })
                       
                        let addButon = UIAlertAction(title: "ADD", style: .default, handler: {  (_) in
                            let textField = alertMessage.textFields![0] // Force unwrapping because we know it exists.
                            self.totalLabelsArray[i].text = textField.text
                            self.totalLabelsArray[i].backgroundColor = UIColor.clear
                            self.totalLabelsArray[i].textColor = UIColor.black
                            })
                        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: {
                       (_) in
                        
                            // present another alert to the user saying you are not re-adding the player to the game again so we are deleting the player from the game 
                            let inneralertMessage = UIAlertController(title: "\((CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?[i])!) will be delelted from the game", message: "Are you sure", preferredStyle: .alert)
                            let okButtonInnerAlertMessage = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                
                                tempForTotalLabelNames.remove(at: i)
                                let nameToDelete = CommonData.sharedInstance.playerNames[CommonData.sharedInstance.gameSelected]?[i]
                                var tempForWorkingInLoop = CommonData.sharedInstance.playerNames["copyOfPlayerNames"]
                                
                                // create an array of bool in CommonData.playerNmaes["boolarrayofdeletedplayers"]
                                let str = CommonData.sharedInstance.gameSelected
                                let keyString = str + "boolArrayForDeletedPlayers"
                                CommonData.sharedInstance.playerNames[keyString]?[i] = "notnot"
                                
                                for ii in 0...(CommonData.sharedInstance.playerNames["copyOfPlayerNames"]?.count)!-1 {
                                    if let nameFromArrayOfcopy = CommonData.sharedInstance.playerNames["copyOfPlayerNames"]?[ii] {
                                        if  nameToDelete == nameFromArrayOfcopy {
                                            tempForWorkingInLoop?.remove(at: ii)
                                        }
                                    }
                                }
                                CommonData.sharedInstance.playerNames["copyOfPlayerNames"] = tempForWorkingInLoop
                                if CommonData.sharedInstance.playerNames["copyOfPlayerNames"]?.count == 1 {
                                    
                                    //take the time stamp and save it in game -> timestamps of common data
                                    var tempTimestampArray:[String] = []
                                    let date = NSDate()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
                                    let dateInStr = dateFormatter.string(from: date as Date)
                                    tempTimestampArray.append(dateInStr)
                                    CommonData.sharedInstance.playerNames["timestamp"] = tempTimestampArray
                                    
                                    // present the winner as only one left outside that is not added to the losers list

                                    let alertMessageFinalSuccessMessage = UIAlertController(title: "\((CommonData.sharedInstance.playerNames["copyOfPlayerNames"]?.first)!) Won", message: "Congratulations", preferredStyle: .alert)
                                    let okButtonFinalSuccessMessage = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alertMessageFinalSuccessMessage.addAction(okButtonFinalSuccessMessage)
                                    self.present(alertMessageFinalSuccessMessage, animated: true, completion: nil)
                                }
                            })
                            let cancelButtonInnerAlertMessage = UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
                            })
                            inneralertMessage.addAction(okButtonInnerAlertMessage)
                            inneralertMessage.addAction(cancelButtonInnerAlertMessage)
                            self.present(inneralertMessage, animated: true, completion: nil)

                        })
                        alertMessage.addAction(addButon)
                        alertMessage.addAction(cancelButton)
                        present(alertMessage, animated: true, completion: nil)
                        }
                    
                    }else if sumInInt! >= 0.8*totalSumAllowedInInt {
                        txtField.backgroundColor = UIColor.red
                    } else if sumInInt! >= 0.6*totalSumAllowedInInt {
                        txtField.backgroundColor = UIColor.yellow
                    }
                }
                }
                
                }
            self.totalLabelsArray = tempForTotalLabelNames

            yAxis = yAxis + 40
            scrollVw.contentSize.height = yAxis
            
        }
        
        
        
    }
    
    
    // textfield delegate methods 
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = textField
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
        
        activeField = textField
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





//MARK: code for scrolling the textfield above the keyboard 

/*- (void)registerForKeyboardNotifications
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(keyboardWasShown:)
        name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillBeHidden:)
        name:UIKeyboardWillHideNotification object:nil];
 
 CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
 
 UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
 scrollView.contentInset = contentInsets;
 scrollView.scrollIndicatorInsets = contentInsets;
 
 // If active text field is hidden by keyboard, scroll it so it's visible
 // Your app might not need or want this behavior.
 CGRect aRect = self.view.frame;
 aRect.size.height -= kbSize.height;
 if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
 [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
 
} */


func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
}


 func keyboardWasShown(notification : NSNotification) {
    print("self.view frame \(self.view.frame)")
    print("self.scrollview frame \(self.scrollVw.frame)")
    print("self.scrollview content size \(self.scrollVw.contentSize)")
    print("self.scrollview content offset \(self.scrollVw.contentOffset)")
    print("self.scrollview content Insets \(self.scrollVw.contentInset)")

    let info : NSDictionary = notification.userInfo as! NSDictionary
    let kbSize: CGSize? = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64, 0, kbSize!.height, 0.0)
    scrollVw.contentInset = contentInsets
    scrollVw.scrollIndicatorInsets = contentInsets
    var aRect: CGRect = view.frame
    aRect.size.height -= (kbSize?.height)!
    if !aRect.contains(activeField.frame.origin) {
        scrollVw.scrollRectToVisible(activeField.frame, animated: true)
        print("self.view frame after\(self.view.frame)")
        print("self.scrollview frame after\(self.scrollVw.frame)")
        print("self.scrollview content size after \(self.scrollVw.contentSize)")
        print("self.scrollview content offset after \(self.scrollVw.contentOffset)")
        print("self.scrollview content Insets after \(self.scrollVw.contentInset)")
    }
    
    
}

func keyboardWillBeHidden(notification : NSNotification) {
 //   let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
    let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64, 0, 0, 0.0)
    scrollVw.contentInset = contentInsets
    scrollVw.scrollIndicatorInsets = contentInsets
    
  /*  if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        let viewHeight = self.view.frame.height
        self.view.frame = CGRect(x: self.view.frame.origin.x,
                                 y: self.view.frame.origin.y,
                                 width: self.view.frame.width,
                                 height: viewHeight + keyboardSize.height)
    } else {
        debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
    }   */
}

 
    
 /*   func keyboardWasShown(_ aNotification: Notification) {
    //    var info: [AnyHashable: Any]? = aNotification.userInfo
    //    var kbSize: CGSize? = (info?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    //    var bkgndRect: CGRect? = activeField.superview?.frame
    //    bkgndRect?.size.height += (kbSize?.height)!
    //    activeField.superview?.frame = bkgndRect!
   //     scrollVw.setContentOffset(CGPoint(x: CGFloat(0.0), y: CGFloat(activeField.frame.origin.y - (kbSize?.height)!)), animated: true)
        
        if let keyboardSize = (aNotification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }  */

}



