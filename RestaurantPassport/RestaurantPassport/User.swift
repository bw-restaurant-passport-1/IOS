//
//  User.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

struct User: Codable,Equatable {
    var username: String
    var strongPassword:String
    var name: String
    var email: String
    
}


