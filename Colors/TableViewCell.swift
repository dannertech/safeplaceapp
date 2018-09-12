//
//  TableViewCell.swift
//  Colors
//
//  Created by Diamonique Danner on 6/24/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
   
 

    
    /*var height : CGFloat {
        get {
            return designView.bounds.size.height
        }
        set {
            return designView.bounds.size.height = newValue
        }
    } */
    
    
    
  
    
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
