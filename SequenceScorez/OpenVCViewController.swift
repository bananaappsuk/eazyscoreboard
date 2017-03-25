//
//  OpenVCViewController.swift
//  SequenceScorez
//
//  Created by Deepthi Kaligi on 02/02/2017.
//  Copyright © 2017 Infosys. All rights reserved.
//

import UIKit
import  FBSDKCoreKit
import FBSDKLoginKit

class OpenVCViewController: UIViewController , FBSDKLoginButtonDelegate {
    
 //   var accessToken : FBSDKAccessToken = FBSDKAccessToken.current()
    
//    var accessToken : FBSDKAccessToken {
//     
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User access token is \(FBSDKAccessToken.current())")
        
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions =  ["public_profile", "email", "user_friends"];
        let y = self.view.frame.size.height - 100
        let x = self.view.frame.size.width/2
        let center = CGPoint(x: x, y: y)
        loginButton.center = center
        view.addSubview(loginButton)

        // Optional: Place the button in the center of your view.
        if (FBSDKAccessToken.current() != nil) {
            // go to next page
            self.performSegue(withIdentifier: "toHomeVC", sender: self)
        }
        
        }
    
    func presentHomeVC() {
        performSegue(withIdentifier: "toHomeVC", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if (FBSDKAccessToken.current() != nil) {
            // go to next page
            print(" view will appear User access token is \(FBSDKAccessToken.current())")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = sb.instantiateViewController(withIdentifier: "SliderRootViewController")
            present(vc, animated: true, completion: nil)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            // go to next page
            print(" view did appear User access token is \(FBSDKAccessToken.current())")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = sb.instantiateViewController(withIdentifier: "SliderRootViewController")
            present(vc, animated: true, completion: nil)
        }
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
    
    // FB Delegate Methods
   
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("sfsfsfsa result \(result)")
        if error == nil {
            // present HoneVC
            performSegue(withIdentifier: "toHomeVC", sender: self)
        } else {
            // present the user some error 
            let alertMessage = UIAlertController(title: "Login Error", message: "Network Error Please try again", preferredStyle: .alert)
            let okButon = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okButon)
            present(alertMessage, animated: true, completion: nil)
        }
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    

}
