//
//  TableViewCell.swift
//  Airdnd
//
//  Created by Shreya Banga on 12/09/19.
//  Copyright © 2019 Shreya Banga. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var houseLocation: UILabel!
    @IBOutlet weak var housePrice: UILabel!
    @IBOutlet weak var houseName: UILabel!
    @IBOutlet weak var houseImage: UIImageView!
    
    
    //vendor properties outlets
    @IBOutlet weak var propName: UILabel!
    @IBOutlet weak var propType: UILabel!
    @IBOutlet weak var propLoc: UILabel!
    @IBOutlet weak var propPrice: UILabel!
    @IBOutlet weak var propRenter: UILabel!
    
    
    //rented properties outlets
    
    @IBOutlet weak var rentName: UILabel!
    @IBOutlet weak var rentType: UILabel!
    @IBOutlet weak var rentLoc: UILabel!
    @IBOutlet weak var rentPrice: UILabel!
    @IBOutlet weak var rentOwner: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
