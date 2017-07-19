//
//  myButton.swift
//  Login_View4
//
//  Created by User on 2017. 7. 17..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class MyButtons: UIView {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    var controlState = UIControlState.normal
    var checkBoolean = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setUpButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch controlState {
        case UIControlState.normal:
            imageView.alpha = 0.5
            titleLabel.text = "Highlighted1"
            titleLabel.textColor = UIColor.white
            controlState = [.normal, .highlighted]
            
        case UIControlState.selected:
            imageView.alpha = 0.5
            titleLabel.text = "Highlighted2"
            titleLabel.textColor = UIColor.red
            controlState = [.selected, .highlighted]
            
        default:
            print( "Error" )
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch controlState {
        case [.normal, .highlighted]:
            imageView.alpha = 1.0
            titleLabel.text = "Selected"
            titleLabel.textColor = UIColor.green
            controlState = .selected
            
        case [.selected, .highlighted]:
            imageView.alpha = 1.0
            titleLabel.text = "Normal"
            titleLabel.textColor = UIColor.yellow
            controlState = .normal
            
        default:
            print("Error")
        }
        print("touch up inside")
        print("button tapped")
    }
    
    private func setUpButton() {
        imageView = UIImageView(frame: self.bounds)
        imageView.backgroundColor = UIColor.black
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewMakeLayOutConstaint()
        
        titleLabel = UILabel()
        titleLabel.text = "Normal"
        titleLabel.textColor = UIColor.yellow
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelMakeLayoutConstraint()
    }
    
    private func imageViewMakeLayOutConstaint() {
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
    }

    private func labelMakeLayoutConstraint(){
        NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 1.0, constant: 30.0).isActive = true
    }
    
}
