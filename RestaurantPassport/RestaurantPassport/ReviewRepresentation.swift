//
//  ReviewRepresentation.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 1/6/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

struct ReviewRepresentation: Equatable, Codable {
    let id: String
    let user_id: String
    var restaurant_id: String
    var myRating: String? = "3"
    var notes: String? = ""
    var stamped: Bool? = false
}


struct PassportRepresentations: Codable {
    let results: [ReviewRepresentation]
}
