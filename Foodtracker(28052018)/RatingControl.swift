//
//  RatingControl.swift
//  Foodtracker(28052018)
//
//  Created by quoccuong on 2018/05/29.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let hightlightedStar = UIImage(named: "hightlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(hightlightedStar, for: [.selected, .highlighted])
            
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
        // Set the accessibility label
        button.accessibilityLabel = "Set \(index + 1) stars rating"
        

        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        addArrangedSubview(button)
            
        ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
             fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
             rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = rating > index
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            //Caculate the valua string
            let valueString : String
            switch (rating) {
            case 0 :
                valueString = "No rating set"
            case 1 :
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityLabel = valueString
        }
    }
}
