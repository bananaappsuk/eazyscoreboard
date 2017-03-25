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
    //variables
    static var menus = [String]()
    
    
    
    var menu : String {
        get {
            return FirstViewController.menus.last!
        }
        set {
            
            FirstViewController.menus.append(newValue)
            tableView.reloadData()
        }
    }

    @IBAction func openMenu() {
        self.slideMenuController()?.openLeft()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        print("view did load is fired")
        // Do any additional setup after loading the view, typically from a nib.
        print("User access token is \(FBSDKAccessToken.current())")
        print("User id is \(FBSDKAccessToken.current().userID)")
        print("app id is \(FBSDKAccessToken.current().appID)")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear is fired")
        
    }

   @IBAction func addANewRow() {
        let alert = UIAlertController(title: "Enter the Name", message: nil, preferredStyle: .alert)
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
