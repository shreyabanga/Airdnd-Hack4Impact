//
//  typeOfUserViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 17/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

//For typeOfVC and profileVC
////////////////////////////

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase
import Foundation

class typeOfUserViewController: UIViewController, FUIAuthDelegate {
    
    
    @IBOutlet weak var profileLast: UILabel!
    @IBOutlet weak var profileFirst: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileMode: UILabel!
  
    
    var uid:String = ""
    var email:String = ""
    var name:String = ""
    
    
    var ref: DatabaseReference!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        if let user = user {
            
             uid = user.uid
            email = user.email!
            name = user.displayName!
            
            //this is getting info from the auth section of firebase
        }
        
        setUp()
        
    }
    
    
    func setUp() { //for profile VC
        
        ref.child("Users").child(self.uid).observe(.value) { (snapshot) in
        
            
            let userModes:String  = (snapshot.childSnapshot(forPath: "userMode").value as! String)
    
        
            self.profileMode.text = userModes
            
        }
        
        let nameArray = name.components(separatedBy: " ")
        
        profileFirst.text = nameArray[0]
        profileLast.text = nameArray[1]
        profileEmail.text = email
        
        
   
        
       
    }
    
    
    
    @IBAction func logOutButton(_ sender: Any) {
        
        print(Auth.auth().currentUser?.displayName!)
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        
    print(Auth.auth().currentUser?.displayName!)
        
        performSegue(withIdentifier: "logOutSegue", sender: self)
        
        

        
    }
    
    
        
    @IBAction func vendorButton(_ sender: Any) {
        
      
        ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
            
            
            if snapshot.hasChild(self.uid)
            {
            self.ref.child("Users").child(self.uid).updateChildValues(["userMode":"Vendor"])
                
                print("Already exists")
                
            }
            else
            {
   
                
                //ref.child("Users").setValue(self.email)
                
                self.ref.child("Users").child(self.uid).setValue(["name":self.name, "uid":self.uid, "email":self.email,"userMode":"Vendor"])
                
            }
        }
 
    }
    
        
    @IBAction func renterButton(_ sender: Any) {
        
        
        ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
        
            if snapshot.hasChild(self.uid)
            {
            self.ref.child("Users").child(self.uid).updateChildValues(["userMode":"Renter"])
                
                print("Already exists")
                
            }
            else
            {
            self.ref.child("Users").child(self.uid).setValue(["name":self.name, "uid":self.uid, "email":self.email,"userMode":"Renter"])
                
            }
        }
        
    }
   
        

    }
    



