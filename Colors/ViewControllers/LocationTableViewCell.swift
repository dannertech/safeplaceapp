//
//  LocationTableViewCell.swift
//  Colors
//
//  Created by Diamonique Danner on 8/9/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet var locationLabel: UILabel!
    var cellTag : Int = 0

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
