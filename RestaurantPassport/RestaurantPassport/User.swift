//
//  User.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

struct User: Equatable, Codable {
    var id: Int
    let username: String
    let password: String
    let name: String
    var email: String
    var city: String
    
}

struct ExistingUser: Equatable, Codable {
    var user: User
}
