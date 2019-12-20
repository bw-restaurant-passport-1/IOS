//
//  RestaurantDetailViewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    // View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Actions
    @IBAction func star1Selected(_ sender: UIButton) {
   
    }
    @IBAction func star2Selected(_ sender: UIButton) {
    }
    @IBAction func star3Selected(_ sender: UIButton) {
    }
    @IBAction func star4Selected(_ sender: UIButton) {
    }
    @IBAction func star5Selected(_ sender: UIButton) {
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
