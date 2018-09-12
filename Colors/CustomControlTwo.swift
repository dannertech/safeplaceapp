//
//  CustomControlTwo.swift
//  Colors
//
//  Created by Diamonique Danner on 6/29/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit

@IBDesignable
class CustomControlTwo: UIControl {
    
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowOffSetHeight : CGFloat = 0
    @IBInspectable var shadowOffSetWidth : CGFloat = 0
    @IBInspectable var shadowColor : UIColor = UIColor.black
    @IBInspectable var shadowOpacity : CGFloat = 0.5
    
    var buttons = [UIButton]()
    
    var selector : UIView!
    
    var selectedSegmentIndex = 0
    
    @IBInspectable var textColor : UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var commaSeparatedButtonTitles : String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectorTextColor : UIColor = .white {
        didSet {
            updateView()
        }
    }
        
   @IBInspectable var selectorColor : UIColor = .darkGray {
        didSet {
            updateView()
        }
        }
    
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach({ (view) in
            view.removeFromSuperview()
            
        })
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width/CGFloat(buttonTitles.count)
selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height/2
        
        selector.backgroundColor = selectorColor
        
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        addSubview(sv)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
    }
    
    @objc func buttonTapped(button: UIButton) {
        for(buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius/2
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }

}

