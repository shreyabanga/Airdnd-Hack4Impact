//
//  userPropertiesViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 20/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class userPropertiesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
    
    
    @IBOutlet weak var TableView: UITableView!
    
    var uid:String = ""
    
    
    struct listing{ //class of listings having different properties
        let name:String
        let image:String
        let price:Float
        let location:String
        let renter:String
        let type:String
    }
    
    
    var listingArray = [listing]() //for containing all the listings
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
        
        ref.child("Users").child(self.uid).child("Properties").queryOrderedByKey().observe(.childAdded) { (snapshot) in
            
            
            if let item = snapshot.value as? [String:Any] {
                
                let name = item["name"] as! String
                let price = item["price"] as! String
                let location = item["location"] as! String
                let renter = item["currentRenter"] as! String
                let type = item["type"] as! String
                
                let priceF = Float(price) //converting to float
                self.listingArray.append(listing(name: name, image: "cozy cottage", price: priceF!, location: location, renter: renter, type: type))
                self.TableView.reloadData()
            }
            
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell //9:54
            else {
                return UITableViewCell()
        }
        
        
        cell.propName.text = listingArray[indexPath.row].name
        cell.propLoc.text = listingArray[indexPath.row].location
        cell.propPrice.text = "$ " +  listingArray[indexPath.row].price.description + "/night"
        cell.propType.text = listingArray[indexPath.row].type
        cell.propRenter.text = listingArray[indexPath.row].renter
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}



