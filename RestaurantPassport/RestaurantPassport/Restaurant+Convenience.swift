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
        let id = self.id ?? UUID()
        let restaurantPictureURL = self.restaurantPictureURL
        return RestaurantRepresentation(id: id, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, restaurantPictureURL: restaurantPictureURL)
    }
    
    // MARK: - Initializers
    @discardableResult convenience init?(id: UUID, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.restaurantName = restaurantName
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
        self.restaurantPictureURL = restaurantPictureURL
        self.id = id
    }
    
    @discardableResult convenience init?(_ representation: RestaurantRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let restaurantName = representation.restaurantName, let id = representation.id else { return nil }
        
        self.init(representation, context: context)
    }
    
    @discardableResult convenience init?(id: UUID, restaurantName: String?, streetAddress: String?, city: String?, zipcode: String?, phoneNumber: String?, websiteURL: String?, restaurantPictureURL: String?) {
        
        self.init()
        self.id = id
        self.restaurantName = restaurantName
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
        self.restaurantPictureURL = restaurantPictureURL
    }
}
