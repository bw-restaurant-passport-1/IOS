//
//  SignUpRequest.swift
//  RestaurantPassport
//
//  Created by Fabiola S on 1/10/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

struct SignUpRequest: Equatable, Codable {
    let username: String
    let password: String
    let name: String
    var email: String
    var city: String
}

struct NewUser: Equatable, Codable {
    var user: SignUpRequest
}
