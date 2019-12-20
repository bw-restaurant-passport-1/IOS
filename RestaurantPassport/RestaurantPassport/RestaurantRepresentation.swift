//
//  RestaurantRepresentation.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

struct RestaurantRepresentation: Equatable, Codable {
    let restaurantName: String = "New Restaurant"
    let streetAddress: String?
    let city: String?
    let zipcode: String?
    let phoneNumber: String?
    let websiteURL: String?
    let myRating: Int = 3
    let notes: String?
    let stamped: Bool = false
}


struct RestaurantRepresentations: Codable {
    let results: [RestaurantRepresentation]
}
