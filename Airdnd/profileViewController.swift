//
//  profileViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 21/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase
import Foundation

class profileViewController: UIViewController, FUIAuthDelegate {


    @IBOutlet weak var profileFirst: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileLast: UILabel!
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
            
            let nameArray = name.components(separatedBy: " ")
            
            //nameArray[1]
            profileEmail.text = email
            //this is getting info from the auth section of firebase
        }
        profileFirst.text = "Yes"
        profileLast.text = "Yes"
        
        setUp()
        
    }
    
    
    func setUp() { //for profile VC
        
        ref.child("Users").child(self.uid).observe(.value) { (snapshot) in
            
            
            let userModes:String  = (snapshot.childSnapshot(forPath: "userMode").value as! String)
        
            self.profileMode.text = userModes
            
        }
        

    }
    
    
    
    
    
    @IBAction func logOutB(_ sender: Any) {
    
    
    print(Auth.auth().currentUser?.displayName!)
    
    do {
    try Auth.auth().signOut()
    } catch let error {
        print(error)
    }
    
    print(Auth.auth().currentUser?.displayName!)
    
    performSegue(withIdentifier: "logOutSegue", sender: self)
    
        
    }
    
}
