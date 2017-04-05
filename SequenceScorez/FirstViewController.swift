//
//  FirstViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 02/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


var selctedGameName : String = ""


class FirstViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    
   // Outlets 
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var rummyBtn : UIButton!
    @IBOutlet weak var cardsGameBtn : UIButton!
    @IBOutlet weak var teenpattiBtn : UIButton!
    @IBOutlet weak var setsGameBtn : UIButton!
    @IBOutlet weak var noRecordsToShowLabel : UILabel!
    // global variable as it is decalred static 
    static var menus = [String]()
    
    
    
    var menu : String {
        get {
            return FirstViewController.menus.last!
        }
        set {
            
            FirstViewController.menus.append(newValue)
            checkIfGameRecordsAreNil()
            tableView.reloadData()
        }
    }

    @IBAction func openMenu() {
        self.slideMenuController()?.openLeft()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //applying edge shadows for the buttons
        
        rummyBtn.fineTuneTheBordersOfButton()
        cardsGameBtn.fineTuneTheBordersOfButton()
        teenpattiBtn.fineTuneTheBordersOfButton()
        setsGameBtn.fineTuneTheBordersOfButton()
        
        print("view did load is fired")
        
        print("User access token is \(FBSDKAccessToken.current())")
        print("User id is \(FBSDKAccessToken.current().userID)")
        print("app id is \(FBSDKAccessToken.current().appID)")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear is fired")
        checkIfGameRecordsAreNil()
      
    }
    
    func checkIfGameRecordsAreNil() {
        if FirstViewController.menus.count > 0 {
            noRecordsToShowLabel.alpha = 0
        } else {
            noRecordsToShowLabel.alpha = 1.0
        }
    }

   @IBAction func addANewRow() {
        let alert = UIAlertController(title: "Enter a Game Name", message: nil, preferredStyle: .alert)
        alert.addTextField { (mytextField) in
            mytextField.keyboardType = UIKeyboardType.alphabet
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action : UIAlertAction) in
            let textField : UITextField = (alert.textFields?.first)!
            self.menu = textField.text!
            print("menu array \(FirstViewController.menus)")
        }))
        present(alert, animated: true, completion: nil)
    }
    

    
    
    // MARK: table view delegate and datasource methods 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstViewController.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = FirstViewController.menus[indexPath.row]
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width)!/2
        cell.imageView?.clipsToBounds = true
        cell.imageView?.image = UIImage(named: "gameimage.png")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //code for editing rows 
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            FirstViewController.menus.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
    
   // Code for moving cells
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let string =  FirstViewController.menus.remove(at: sourceIndexPath.row)
        FirstViewController.menus.insert(string, at: destinationIndexPath.row)
        
    }
    
    //code for unselecting the cells
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selctedGameName = FirstViewController.menus[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            print("inside prepare for segue of first view controller")
            if let vc = segue.destination as? SecondViewController {
                let indexpath = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: indexpath!)
                if let gameName = cell?.textLabel?.text {
                    vc.gameSelected = gameName
                    CommonData.gameSelected = gameName
                }
            }
        } else if segue.identifier == "fromrummybutton" {
            if let vc = segue.destination as? SecondViewController {
                vc.gameSelected = "rummy"
                CommonData.gameSelected = "rummy"
            }
        } else if segue.identifier == "fromsevencardsgamebutton" {
            if let vc = segue.destination as? SecondViewController {
                vc.gameSelected = "sevencardgame"
                CommonData.gameSelected = "sevencardgame"
            }
        } else if segue.identifier == "fromteenpattibutton" {
            if let vc = segue.destination as? SecondViewController {
                vc.gameSelected = "teenpatti"
                CommonData.gameSelected = "teenpatti"
            }
        } else if segue.identifier == "fromsetsgamebutton" {
            if let vc = segue.destination as? SecondViewController {
                vc.gameSelected = "sets"
                CommonData.gameSelected = "sets"
            }
        }
    }
    
    
}


extension UIImageView {
    @IBInspectable var   cournerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


extension UIButton {
    
    public func fineTuneTheBordersOfButton() {
      //  self.layer.borderColor = UIColor.darkGray.cgColor
      //  self.layer.borderWidth = 3.0
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 3)
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
    }
}
