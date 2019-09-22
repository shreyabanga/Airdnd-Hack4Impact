//
//  hostViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 20/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase


class hostViewController: UIViewController, FUIAuthDelegate {

  // var loginVC: loginViewController = loginViewController(nibName: nil, bundle: nil) //instannce of login view controller to get uid from it
    var uid:String = ""
    var userName:String = ""
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    
    
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
            userName = user.displayName!
            
           
        }
        
    }
    

    @IBAction func doneButton(_ sender: Any) {
        
        
        let name = nameText.text
        let price = priceText.text
        let location = locationText.text
        let type = typeText.text
        
        
        //checking if fields are empty
        if (name?.isEmpty == true || price?.isEmpty == true || location?.isEmpty == true || type?.isEmpty == true) {
            
            
            //displaying alert
            let alert = UIAlertController(title: "Incomplete Fields", message: "Please enter all the fields", preferredStyle: .alert)
            let warningButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(warningButton)
            self.present(alert, animated: true, completion: nil )
            
            
        }
            
        else {
            
            
            
            //updating properties in the listings database
            var snapRef = self.ref.child("Listings").childByAutoId()
        snapRef.updateChildValues(["name":name!,"price":price!,"location":location!,"type":type!,"currentRenter":"nil","owner":self.userName,"ownerUID":self.uid])
            
            
            //getting the random prop ID
            let propID = snapRef.key
            
            
            //updating properties in the user database
        self.ref.child("Users").child(self.uid).child("Properties").child(propID).updateChildValues(["name":name!,"price":price!,"location":location!,"type":type!,"currentRenter":"nil"])
            
            
            //displaying alert
            
            let alert = UIAlertController(title: "Success!", message: "Your property is now available to be rented", preferredStyle: .alert)
            let warningButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(warningButton)
            self.present(alert, animated: true, completion: nil )
            
            
            //resetting the text fields
            
            nameText.text = ""
            priceText.text = ""
            locationText.text = ""
            typeText.text = ""
            
            
            
        }
        
        
            
    }
    
        
}
    


