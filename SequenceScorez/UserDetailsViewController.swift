//
//  UserDetailsViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 17/04/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var lastGame : Game = Game(players: [])
    var picker : UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var txtFieldName : UITextField!
    @IBOutlet weak var imageViewUserPic : UIImageView!

    
    
    
    @IBAction func backToNewGameVC (sender : UIButton) {
      _ =  navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveUserDetailsToDisk(sender : UIButton) {
        // save the details to the Model class
        if let playerName = txtFieldName.text {
            if playerName != "" {
                if let lGame = CommonData.sharedInstance.data[CommonData.sharedInstance.gameSelected]?["games"]?.last  {
                    
                    lastGame = lGame
                    lastGame.players.append(playerName)
                    
                    if let image = imageViewUserPic.image {
                        var tempDict :[String : UIImage] = [:]
                        tempDict[playerName] = image
                        lastGame.playerImages.append(tempDict)
                    }
                }
               

            }
        }
        print("now games in that common data \(CommonData.sharedInstance.data[CommonData.sharedInstance.gameSelected]?["games"])")
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    
    
    
    
    
    
    
    //MARK: imagePicker controller delegate code
    
   @IBAction func showPickerViewController(gestureRecognizer : UITapGestureRecognizer) {
        
        // change the value of cell tag to the one we got on user tapping on imageview for placing his image
        
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let option1 = UIAlertAction(title: "album", style: UIAlertActionStyle.default) { (action) in
            //code for photo libraray
            self.picker.delegate = self
            self.picker.allowsEditing = true
            self.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            
        }
        let option2 = UIAlertAction(title: "camera", style: UIAlertActionStyle.default) { (action) in
            // code for camera
            self.picker.delegate = self
            self.picker.allowsEditing = true
            self.picker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(self.picker, animated: true, completion: nil)
        }
        let option3 = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (action) in
        }
        actionController.addAction(option1)
        actionController.addAction(option2)
        actionController.addAction(option3)
        present(actionController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage: UIImage? = info[UIImagePickerControllerEditedImage] as! UIImage?
        //replace the default pic
        imageViewUserPic.image = chosenImage
        picker.dismiss(animated: true, completion: { _ in })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
