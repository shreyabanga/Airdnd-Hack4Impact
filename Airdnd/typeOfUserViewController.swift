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
            
            
           
        }
       
        
      
        
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
    



