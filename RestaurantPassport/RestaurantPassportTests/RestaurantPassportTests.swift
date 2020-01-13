//
//  RestaurantPassportTests.swift
//  RestaurantPassportTests
//
//  Created by Fabiola S on 1/13/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import XCTest
@testable import RestaurantPassport

class RestaurantPassportTests: XCTestCase {
    let loginViewController = LoginViewController()
    let userController = UserController()
    let restaurantController = RestaurantController()
    let reviewController = ReviewController()
    
    let signupRequest = SignUpRequest(username: "Unit Test", password: "testing", name: "Unit Test", email: "unittesting@unittest.com", city: "Chicago")
    let user = User(id: 23, username: "FabiolaTest", password: "testing", name: "Fabiola", email: "saga.fabiola@gmail.com", city: "chicago")
    
    func testCreateUser() {
        userController.signup(type: .newUser, with: signupRequest, completion: { error in
            if let error = error {
                print("Error occured during sign up: \(error)")
            } else {
                DispatchQueue.main.async {
                    print("Sign Up Succesful")
                }
            }
        })
    }
    
    func testLogIn() {
        userController.login(type: .existingUser, withUsername: "FabiolaTest", withPassword: "testing") { error in
            if let error = error {
                print("Error occured during log in: \(error)")
            } else {
                DispatchQueue.main.async {
                    print("Log in Successful")
                }
            }
        }
    }
}
