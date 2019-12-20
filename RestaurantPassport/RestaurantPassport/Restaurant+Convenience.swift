//
//  Restaurant+Convenience.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant {
    
    // MARK: - Properties
    var restaurantRepresentation: RestaurantRepresentation? {
        
        guard let restaurantName = restaurantName,
        let stamped = stamped,
            let myRating = myRating else { return nil }
        return RestaurantRepresentation(restaurantName: restaurantName, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, myRating: myRating, notes: notes, stamped: stamped)
    }
    
    // MARK: - Initializers
    @discardableResult convenience init? (restaurantName: restaurantName, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, myRating: myRating, notes: notes, stamped: stamped, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.restaurantName = restaurantName
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
        self.myRating = myRating
        self.notes = notes
        self.stamped = stamped
    }
    
    @discardableResult convenience init?(_ representation: RestaurantRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let restaurantName = representation.restaurantName,
            let stamped = representation.stamped,
            let myRating = representation.myRating else {return nil}
        
        self.init((restaurantName: restaurantName, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, myRating: myRating, notes: notes, stamped: stamped, context: context))
    }
}
