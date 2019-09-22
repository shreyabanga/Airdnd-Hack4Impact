//
//  rentViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 21/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

class rentViewController: UIViewController {

    
    var ref: DatabaseReference!
    var uid:String = ""
    var displayName:String = ""
   
    @IBOutlet weak var propName: UILabel!
    @IBOutlet weak var propType: UILabel!
    @IBOutlet weak var propLoc: UILabel!
    @IBOutlet weak var propPrice: UILabel!
    @IBOutlet weak var propOwner: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    
    
    var name:String = ""
    var price:String = ""
    var location:String = ""
    var type:String = ""
    var owner:String = ""
    var propID:String = ""
    var ownerID:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        propName.text = name
        propLoc.text = location
        propPrice.text = "$ " +  price + "/night"
        propOwner.text = owner
        propType.text = type
        
        getInfo()

     
    }
    
    
    @IBAction func rentPressed(_ sender: Any) {
        
        //alert
        let alert = UIAlertController(title: "Success!", message: "You have successfully rented this property", preferredStyle: .alert)
        let warningButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(warningButton)
        self.present(alert, animated: true, completion: nil )
        
       
        //change current renter
        
        
        //updating properties in the user database
   //owner
        
        self.ref.child("Users").child(ownerID).child("Properties").child(propID).updateChildValues(["currentRenterUID":self.uid, "currentRenter":displayName])
        
        //renter
        self.ref.child("Users").child(self.uid).child("Properties").child(propID).updateChildValues(["name":name,"price":price,"location":location,"type":type,"ownerID":ownerID, "owner":owner])
        
        
        //updating properties in the listings database
    self.ref.child("Listings").child(propID).updateChildValues(["currentRenter":self.uid])
        
        
        
        
        
        rentButton.isEnabled = false
        
        
        
    }
    
    func getInfo()
    {
        let user = Auth.auth().currentUser //get current user's id
        if let user = user {
            
             uid = user.uid
            displayName = user.displayName!
        }
        
        ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.childSnapshot(forPath: self.uid).hasChild("userMode")
            {
                let userModes:String  = (snapshot.childSnapshot(forPath: self.uid).childSnapshot(forPath: "userMode").value as! String)
                
                if userModes == "Vendor"
                {
                    self.rentButton.isHidden = true
                }
                else {
                    self.rentButton.isHidden = false
                }
                
            }
            
        }
        
    }
 
}
