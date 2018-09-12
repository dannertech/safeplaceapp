//
//  CustomTableViewCell.swift
//  Colors
//
//  Created by Diamonique Danner on 8/8/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
   
    @IBOutlet var destinationLabel: UILabel!
    
    @IBOutlet var longitudeLabel: UILabel!
   
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var latitudeLabel: UILabel!
   
    @IBOutlet var locationNameLabel: UILabel!
    
    
    
    
    

    var cellTag : Int = 0
    
    
    

 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

   

}
