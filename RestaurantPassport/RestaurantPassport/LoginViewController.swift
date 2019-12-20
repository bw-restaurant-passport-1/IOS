//
//  LoginViewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Methods
    // View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
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
