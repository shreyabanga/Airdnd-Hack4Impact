//
//  loginViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 14/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

class loginViewController: UIViewController, FUIAuthDelegate {

    
    var ref: DatabaseReference! //making a ddatabase refrnce
    var uid:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
      
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        let authUI=FUIAuth.defaultAuthUI() //returns optional
        guard authUI != nil //we neeed to log eerror
            else {
                return
        }
        
        authUI?.delegate = self
        
        
        let authViewController = authUI!.authViewController() //google provides its ownn view controller
        
        present(authViewController, animated: true, completion: nil)
        
        
    }
    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) { //if finnished signningn inn, presennt the next view controllr
        if error != nil {
            return
        }
        
        
        let user = Auth.auth().currentUser //get current user's id
        if let user = user {
            
            uid = user.uid
        }
        
        ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
            
            //bbasically checking if user has seelected a mode or not after signning in
            if snapshot.childSnapshot(forPath: self.uid).hasChild("userMode")
            {
                let userModes:String  = (snapshot.childSnapshot(forPath: self.uid).childSnapshot(forPath: "userMode").value as! String)
                
                
                if(userModes == "Vendor")
                {
                    //already configured the type of venndor
                    self.performSegue(withIdentifier: "tabBarSegue", sender: self)
                }
                else {
                    
                    //configured the type of renter
                    self.performSegue(withIdentifier: "tabBarSegueTwo", sender: self)
                    
                }
                
            }
                
            else
            {
                //not configured, show the two options
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                
            }
        }
    }
    
    
}
    
   
   



