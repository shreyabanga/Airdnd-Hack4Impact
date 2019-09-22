//
//  userRentedViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 21/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class userRentedViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var uid:String = ""
    var listingArray = [listing]()
    
    
    @IBOutlet weak var TableView: UITableView!
    
    struct listing{ //class of listings having different properties
        let name:String
        let price:Float
        let location:String
        let owner:String
        let type:String
    }
    
    
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
                let owner = item["owner"] as! String
                let type = item["type"] as! String
                
                let priceF = Float(price) //converting to float
                self.listingArray.append(listing(name: name, price: priceF!, location: location, owner: owner, type: type))
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
        
        
        cell.rentName.text = listingArray[indexPath.row].name
        cell.rentLoc.text = listingArray[indexPath.row].location
        cell.rentPrice.text = "$ " +  listingArray[indexPath.row].price.description + "/night"
        cell.rentType.text = listingArray[indexPath.row].type
        cell.rentOwner.text = listingArray[indexPath.row].owner
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}
