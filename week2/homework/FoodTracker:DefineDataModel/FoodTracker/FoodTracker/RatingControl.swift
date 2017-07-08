//
//  RatingControl.swift
//  FoodTracker
//
//  Created by User on 2017. 7. 8..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView  {
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    
    
    
    //MARK: Properties - buttons
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Initiailization
    override init(frame: CGRect) {
        //Super 클래스의 초기화
        super.init(frame: frame)
        setupButtons()
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    
    //MARK: Private Methods
    
    private func setupButtons(){
        
        //Clear Any Existing Buttons
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar.png", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar.png", in: bundle, compatibleWith: self.traitCollection)
        let highlightStar = UIImage(named: "highlightedStar.png", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        
        for index in 0..<starCount{
            //Create the button
            let button = UIButton()
            
            
            //Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightStar, for: .highlighted)
            
            button.setImage(highlightStar, for: [.highlighted, .selected])
            
            
            
            //버튼의 자동생성제약조건 비활성화.
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //button의 높이와 너비를 각각 정의.
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            //Set the accessibility label
            button.accessibilityLabel = "Set \(index+1) star rating"
            
            //코드로 버튼의 액션 설정.
            //
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            
            //Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
        
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton){
        //선택된 버튼 찾아 인덱스 반환.
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)" )
        }
    
    
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    
    }
    
    private func updateButtonSelectionStates() {
        
        
        // 버튼의 인덱스가 등급보다 낮으면 선택된 별 이미지로 변경.
        for ( index, button ) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zerg"
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch rating  {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
        
        
        
    }
    
    
    

}
