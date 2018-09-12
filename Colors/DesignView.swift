//
//  DesignView.swift
//  Colors
//
//  Created by Diamonique Danner on 6/22/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignView : UIView {
    
 
    
    var newValue : CGFloat = 0
    
   
    
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWidth : Int = 0
    @IBInspectable var shadowOffSetHeight : Int = 1
    
    @IBInspectable var shadowOpacity : Float = 0.2
    
   override func layoutSubviews() {
        layer.cornerRadius = cornerRadius/2
    layer.shadowColor = shadowColor?.cgColor
    layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
    
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    
    layer.shadowPath = shadowPath.cgPath
    
    layer.shadowOpacity = shadowOpacity
    }
    
}
