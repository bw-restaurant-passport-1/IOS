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
    // Need to connect to storyboard:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Properties
    var userController: UserController?
    var loginType = LoginType.signUp
    var user: User?
    
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
            !password.isEmpty {
            
            
            
            if loginType == .signUp {
                if let name = fullNameTextField.text,
                    !name.isEmpty,
                    let city = cityTextField.text,
                    !city.isEmpty,
                    let email = emailTextField.text,
                    !email.isEmpty {
                    
                    let signupRequest = SignUpRequest(username: username, password: password, name: name, email: email, city: city)
                    userController.signup(type: .newUser, with: signupRequest) { error in
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
                                    self.fullNameTextField.isHidden = true
                                    self.emailTextField.isHidden = true
                                    self.cityTextField.isHidden = true
                                    self.nameLabel.isHidden = true
                                    self.cityLabel.isHidden = true
                                    self.emailLabel.isHidden = true
                                    self.loginButton.setTitle("Log In", for: .normal)
                                })
                            }
                        }
                    }
                }
            } else if loginType == .login {
                userController.login(type: .existingUser, withUsername: username, withPassword: password) { error in
                    if let error = error {
                        print("Error occured during log in: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Log In successful!", message: "Welcome Back!", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //Need to connect to storyboard:
    @IBAction func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            usernameTextField.text = nil
            passwordTextField.text = nil
            fullNameTextField.text = nil
            emailTextField.text = nil
            cityTextField.text = nil
            fullNameTextField.isHidden = false
            emailTextField.isHidden = false
            cityTextField.isHidden = false
            nameLabel.isHidden = false
            cityLabel.isHidden = false
            emailLabel.isHidden = false
            self.loginButton.setTitle("Sign Up", for: .normal)
        } else if sender.selectedSegmentIndex == 1 {
            loginType = .login
            usernameTextField.text = nil
            passwordTextField.text = nil
            fullNameTextField.isHidden = true
            emailTextField.isHidden = true
            cityTextField.isHidden = true
            nameLabel.isHidden = true
            cityLabel.isHidden = true
            emailLabel.isHidden = true
            self.loginButton.setTitle("Log In", for: .normal)
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
