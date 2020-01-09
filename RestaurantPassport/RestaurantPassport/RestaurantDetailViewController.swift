//
//  RestaurantDetailViewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit
import Foundation

class RestaurantDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    let restaurantController = RestaurantController()
    let reviewController = ReviewController()
    var restaurant: Restaurant?
    var review: Review?
    
    
    // MARK: - Methods
    // View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // Actions
    func updateViews() {
        guard let restaurant = restaurant else {
            self.title = "Add a Restaurant"
            saveButton.title = "Save"
            return
        }
        self.title = restaurant.restaurantName
        //TODO: Figure out how to display image from URL
        //imageView. restaurant.restaurantPictureURL
        nameTextField.text = restaurant.restaurantName
        // TODO: Figure out how to display star rating
        addressTextField.text = restaurant.streetAddress
        cityTextField.text = restaurant.city
        zipcodeTextField.text = restaurant.zipcode
        websiteTextField.text = restaurant.websiteURL
        phoneTextField.text = restaurant.phoneNumber
        notesTextView.text = review?.notes
        saveButton.title = "Save Changes"
    }

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
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // TODO: Fix picture URL to find picture
        guard saveButton.title == "Save" else {
            restaurantController.createRestaurant(with: nameTextField.text, streetAddress: addressTextField.text, city: cityTextField.text, zipcode: zipcodeTextField.text, phoneNumber: phoneTextField.text, websiteURL: websiteTextField.text, restaurantPictureURL: "")
            // TODO: figure out how to create myRating correctly
            reviewController.createReview(restaurant_id: restaurant?.id?.uuidString ?? "", myrating: "3", notes: notesTextView.text, stamped: true)
            return
        }
        let updatedRestaurant = RestaurantRepresentation(id: restaurant!.id, streetAddress: addressTextField.text, city: cityTextField.text, zipcode: zipcodeTextField.text, phoneNumber: phoneTextField.text, websiteURL: websiteTextField.text, restaurantPictureURL: "")
        restaurantController.updateRestaurant(with: [updatedRestaurant])
    }
}
