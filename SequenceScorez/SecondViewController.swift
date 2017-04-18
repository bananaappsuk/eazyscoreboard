//
//  SecondViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 02/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource , changePictureProtocol , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
  


    
    // outlets
    @IBOutlet weak var switchLowScoreWins : UISwitch!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var tableViewMenu : UITableView!
    @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var btnAdd : UIButton!
    @IBOutlet weak var proceed : UIBarButtonItem!
    @IBOutlet weak var maxTotalGameScore : UITextField!
    @IBOutlet weak var initialDropScore : UITextField!
    @IBOutlet weak var middleDropScore : UITextField!
    @IBOutlet weak var maxScorePerGame : UITextField!

    // properties 
    var picker : UIImagePickerController = UIImagePickerController()

    var pickerData  : [String] = []
    
    var cellTagForPlacingPlayerImage : Int  = 0
    // this variable is for detecting which dictionary to consider while filling up the table data
    var gameSelected : String = ""
    var table1DataForRows : [String] = []
    var isFirstRowSelected : Bool = false
    
    @IBAction func addANewRow() {
        let alert = UIAlertController(title: "Enter the Player Name", message: nil, preferredStyle: .alert)
        alert.addTextField { (mytextField) in
            mytextField.keyboardType = UIKeyboardType.alphabet
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action : UIAlertAction) in
            let textField : UITextField = (alert.textFields?.first)!
            CommonData.sharedInstance.playerNames[self.gameSelected]?.append(textField.text!)
            self.tableView.reloadData()
            
        }))
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func presentNextVC() {
        print("sdfsfdsgdsggdsdshhh ")
    }
    
    @IBAction func fireTableViewEditingDelegateMethods() {
        //        if FirstViewController.menus.count != 0 {
        //            let k = FirstViewController.menus.count
        //            var indexPath : [IndexPath] = []
        //            for i : Int in 0...k-1 {
        //                let indexpath = IndexPath(row: i, section: 0)
        //                indexPath.append(indexpath)
        //            }
        //            tableView.delegate?.tableView(self.tableView, willBeginEditingRowAt: indexPath)
        //        }
        //        let indexpath : IndexPath = IndexPath(row: 0, section: 0)
        //        let cell : UITableViewCell = tableView.cellForRow(at: indexpath)!
        //        cell.setEditing(true, animated: true)
        
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing {
            btnEdit.setTitle("Done", for: .normal)
        } else {
            btnEdit.setTitle("Edit", for: .normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMenu.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // create an entry in the static dictionary for the selected game 
        if CommonData.sharedInstance.playerNames[gameSelected]  == nil {
            CommonData.sharedInstance.playerNames[gameSelected] = []
        }
        table1DataForRows.append(gameSelected)
        table1DataForRows.append("Game Type")
        table1DataForRows.append("Calculation Mode")
        print("static variables can hold its contents even the vc is removed from memory \(CommonData.sharedInstance.playerNames)")
        print("child 1 view did load fired")
        // Do any additional setup after loading the view, typically from a nib.
        pickerData = ["Default", "Scores add to Zero", "Winer takes it all", "Highest Wins", "Lowest Wins"]
        
        addDoneButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("child 1 view will appear fired")
        tableView.reloadData()
    }

   
    
    
    
    //MARK:- pickerview delegate and datasource methods
    
    // The number of columns of data
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    
    //MARK:- tableview delgate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
           return 3
        } else if tableView.tag == 2 {
        return (CommonData.sharedInstance.playerNames[gameSelected]?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table1celltype", for: indexPath)
         cell.textLabel?.text = table1DataForRows[indexPath.row]
            if indexPath.row == 0 {
                cell.accessoryType = .none
                cell.tag = 1
                cell.textLabel?.textAlignment = NSTextAlignment.center
            }
            return  cell
        }
        else if tableView.tag == 2 {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
            cell.delegate = self
            cell.tag = indexPath.row
            //  first check if there is a user photo in the disk
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            if (CommonData.sharedInstance.playerNames[gameSelected]?.count)! > 0 {
                let filePath = paths[0] + "/" + (CommonData.sharedInstance.playerNames[gameSelected]?[indexPath.row])! + ".png"
                let dataOfPhoto = NSData(contentsOfFile: filePath)
                if dataOfPhoto != nil {
                    let image = UIImage(data: dataOfPhoto as! Data)
                    if image != nil {
                        cell.imgViewPlayer.image = image
                    }
                } else {
                    cell.imgViewPlayer.image = UIImage(named: "defaultplayer.png")
                }
            }
            
            
            
            cell.lblPlayerName.text = CommonData.sharedInstance.playerNames[gameSelected]?[indexPath.row]
          return cell
        }
        return UITableViewCell()
           }
    
    
    //code for editing rows
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.tag == 1 {
            return false
        }
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            CommonData.sharedInstance.playerNames[gameSelected]?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 44
        }
        return 80
    }
    
    
    
    
    
    
    
    // table view cell delegate methods 
    
    func loadNewScreen(cellIndex cellTag: Int) {
        
        // change the value of cell tag to the one we got on user tapping on imageview for placing his image
        cellTagForPlacingPlayerImage = cellTag
        
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

    let cell = tableView.cellForRow(at: IndexPath(row: cellTagForPlacingPlayerImage, section: 0)) as? CustomTableViewCell
        let chosenImage: UIImage? = info[UIImagePickerControllerEditedImage] as! UIImage?

        //prepare the background to save the photo with the same name in the disk
        if let playerName = cell?.lblPlayerName.text {
          let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = paths[0] + "/" + playerName + ".png"
            do {
                let fileUrl = NSURL(fileURLWithPath: filePath)
                if let pickedImage = chosenImage {
                  try  UIImagePNGRepresentation(pickedImage)?.write(to: fileUrl as URL, options: .atomic)
                }
            } catch {
                print("catch block executed ")
            }

        }
           print("choosen image \(chosenImage)")
           cell?.imgViewPlayer.image = chosenImage
           tableView.reloadData()
           picker.dismiss(animated: true, completion: { _ in })
    }
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            isFirstRowSelected = true
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let indx = tableViewMenu.indexPathForSelectedRow {
            let cell = tableViewMenu.cellForRow(at: indx)
            if cell?.tag == 1 {
                return false
            }
        }
       
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenuDetailViewController" {
            let indx = tableViewMenu.indexPathForSelectedRow
            _ = tableViewMenu.cellForRow(at: indx!)
            let destinationVC = segue.destination as? MenuDetailViewController
            if indx?.row == 1 {
                destinationVC?.stringFromBeforeVC = "Game Type"
            } else if indx?.row == 2 {
                destinationVC?.stringFromBeforeVC = "Calculation Mode"
            }
        }
        else if segue.identifier == "toScoreViewController" {
            //saving the maxtotalgamescroe,initialDropScore,middleDropScore and maxScorePerGame to the local variables of ScoreViewController so that they can be used in the next screen 
            if let destinationVC = segue.destination as? ScoreViewController  {
                destinationVC.maxTotalGameScore =  self.maxTotalGameScore.text
                destinationVC.initialDropScore = self.initialDropScore.text
                destinationVC.middleDropScore = self.middleDropScore.text
                destinationVC.maxScorePerGame = self.maxScorePerGame.text
            }
        }
    }
    
    
   // unwind code
    
      @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
            print("unwind successful")
        let fromVC = segue.source as? MenuDetailViewController
        if isFirstRowSelected == true {
            tableViewMenu.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text = fromVC?.returnStringToSecondVC
            isFirstRowSelected = false
        } else {
          tableViewMenu.cellForRow(at: IndexPath(row: 2, section: 0))?.textLabel?.text = fromVC?.returnStringToSecondVC
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        maxTotalGameScore.resignFirstResponder()
        initialDropScore.resignFirstResponder()
        middleDropScore.resignFirstResponder()
        maxScorePerGame.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        maxTotalGameScore.inputAccessoryView = keyboardToolbar
        initialDropScore.inputAccessoryView = keyboardToolbar
        middleDropScore.inputAccessoryView = keyboardToolbar
        maxScorePerGame.inputAccessoryView = keyboardToolbar

    }
    
    
    
    
    
    
    
    
}

