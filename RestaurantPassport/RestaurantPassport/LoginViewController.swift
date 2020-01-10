//
//  LoginViewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case login
}

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: Properties
    var userController: UserController?
    var loginType = LoginType.signUp
    
    // MARK: - Methods
    // View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let userController = userController else { return }
        
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let name = fullNameTextField.text,
            !name.isEmpty,
            let city = cityTextField.text,
            !city.isEmpty,
            let email = emailTextField.text,
            !email.isEmpty {
            
            let user = User(username: username, password: password, name: name, email: email, city: city)
            
            if loginType == .signUp {
                userController.signup(with: user) { error in
                    if let error = error {
                        print("Error occured during sign up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign up successful!", message: "Now please log in.", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion:  {
                                self.loginSegmentedControl.selectedSegmentIndex = 1
                                self.loginType = .login
                                self.passwordTextField.text = nil
                                self.loginButton.setTitle("Log in", for: .normal)
                            })
                        }
                    }
                }
            } else {
                userController.login(with: user) { error in
                    if let error = error {
                        print("Error occured during log in: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    //Todo: Need to connect to storyboard
    @IBAction func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            passwordTextField.text = nil
            loginButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .login
            passwordTextField.text = nil
            loginButton.setTitle("Log in", for: .normal)
        }
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
