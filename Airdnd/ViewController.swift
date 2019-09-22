//
//  ViewController.swift
//  Airdnd
//
//  Created by Shreya Banga on 12/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
   
    
    @IBOutlet weak var TableView: UITableView!
    
    
    struct listing{ //class of listings having different properties
        let name:String
        let image:String
        let price:Float
        let location:String
        let owner:String
        let type:String
        let ownerID:String
        let propID:String
        var currentRenter:String
    }
    
    
    var listingArray = [listing]() //for containing all the listings
   
  
    override func viewWillAppear(_ animated: Bool) {
        
        print("appear")
        dump(listingArray)
        
        let ref = Database.database().reference()
        
        ref.child("Listings").queryOrderedByKey().observe(.childChanged) { (snapshot) in
            
           
                if let index = self.listingArray.firstIndex(where: { $0.propID == snapshot.key }) {
                   // self.listingArray[index].currentRenter = item["currentRenter"] as! String
                    self.listingArray.remove(at: index)
                }
            
            
            dump(self.listingArray)
        }
        
        self.TableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        
        ref.child("Listings").queryOrderedByKey().observe(.childAdded) { (snapshot) in
           
            
            if let item = snapshot.value as? [String:Any] {
                
                let name = item["name"] as! String
                let owner = item["owner"] as! String
                let price = item["price"] as! String
                let location = item["location"] as! String
                let type = item["type"] as! String
                let currentRenter = item["currentRenter"] as! String
                
                let priceF = Float(price) //converting to float
                let ownerID = item["ownerUID"] as! String
                let propID = snapshot.key
                
                
                if(currentRenter=="nil") {
                    
                
                    self.listingArray.append(listing(name: name, image: "cozy cottage", price: priceF!, location: location, owner: owner, type: type, ownerID: ownerID, propID: propID, currentRenter: currentRenter)) //*
                   print("load")
                    dump(self.listingArray)
                self.TableView.reloadData()
                }
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
       
        if listingArray[indexPath.row].currentRenter == "nil" {
        cell.houseName.text = listingArray[indexPath.row].name
        cell.houseLocation.text = listingArray[indexPath.row].location
        cell.housePrice.text = "$ " +  listingArray[indexPath.row].price.description + "/night"
       
        }
        return cell
        
    }
    
    //setting height of each cell of the table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    //this funnc gets called when you click on a cell
    //presents a detailed view of the property
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rentVC = storyboard?.instantiateViewController(withIdentifier: "rentViewController") as? rentViewController
        
        rentVC?.name = listingArray[indexPath.row].name
        rentVC?.type = listingArray[indexPath.row].type
        rentVC?.price = listingArray[indexPath.row].price.description 
        rentVC?.location = listingArray[indexPath.row].location
        rentVC?.owner = listingArray[indexPath.row].owner
        rentVC?.ownerID = listingArray[indexPath.row].ownerID
        rentVC?.propID = listingArray[indexPath.row].propID
        
        self.navigationController?.pushViewController(rentVC!, animated: true)
    }

}


