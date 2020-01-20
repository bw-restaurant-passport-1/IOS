//
//  RestaurantTableViewCell.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var stampButton: UIButton!
    
    // MARK: - Properties
    var restaurant: RestaurantRepresentation? {
        didSet {
            updateViews()
        }
    }
    var review: ReviewRepresentation? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Methods
    // View
    private func updateViews() {
        nameLabel.text = restaurant?.restaurantName
        // TODO: Set up myRating and stamped buttons
    }
    
    // Actions
        @IBAction func star1Selected(_ sender: UIButton) {
        star1Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star2Button.setImage(UIImage(systemName: "star"), for: .normal)
        star3Button.setImage(UIImage(systemName: "star"), for: .normal)
        star4Button.setImage(UIImage(systemName: "star"), for: .normal)
        star5Button.setImage(UIImage(systemName: "star"), for: .normal)
        review?.myRating = "1"
    }
    @IBAction func star2Selected(_ sender: UIButton) {
        star1Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star2Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star3Button.setImage(UIImage(systemName: "star"), for: .normal)
        star4Button.setImage(UIImage(systemName: "star"), for: .normal)
        star5Button.setImage(UIImage(systemName: "star"), for: .normal)
        review?.myRating = "2"
    }
    @IBAction func star3Selected(_ sender: UIButton) {
        star1Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star2Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star3Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star4Button.setImage(UIImage(systemName: "star"), for: .normal)
        star5Button.setImage(UIImage(systemName: "star"), for: .normal)
        review?.myRating = "3"
    }
    @IBAction func star4Selected(_ sender: UIButton) {
        star1Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star2Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star3Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star4Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star5Button.setImage(UIImage(systemName: "star"), for: .normal)
        review?.myRating = "4"
    }
    @IBAction func star5Selected(_ sender: UIButton) {
        star1Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star2Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star3Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star4Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        star5Button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        review?.myRating = "5"
    }
}
