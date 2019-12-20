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
        
        guard restaurantName != nil else { return nil }
        let streetAddress = self.streetAddress ?? "123 Main St."
        let city = self.city ?? "My City"
        let zipcode = self.zipcode ?? "12345-1234"
        let phoneNumber = self.phoneNumber ?? "(123) 456-7890"
        let websiteURL = self.websiteURL ?? "www.website.com"
        let notes = self.notes ?? "Notes about Restaurant"
        return RestaurantRepresentation(streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, notes: notes)
    }
    
    // MARK: - Initializers
    @discardableResult convenience init?(restaurantName: String, myRating: Int16, stamped: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
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
            let myRating = representation.myRating else { return nil }
        
        self.init(restaurantName: restaurantName, myRating: myRating, stamped: stamped, context: context)
    }
}
