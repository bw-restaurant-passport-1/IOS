//
//  Review+Convenience.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 1/6/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation
import CoreData

extension Review {
    
    // MARK: - Properties
    var reviewRepresentation: ReviewRepresentation? {
        
        guard user_id != nil, id != nil else { return nil }
        let notes = self.notes ?? "Notes about Restaurant"
        let restaurant_id = self.restaurant_id ?? UUID().uuidString
        return ReviewRepresentation(id: id!, user_id: user_id!, restaurant_id: restaurant_id, notes: notes)
    }
    
    // MARK: - Initializers
    @discardableResult convenience init?(id: String, restaurant_id: String, myRating: String, stamped: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.id = id
        self.user_id = user_id
        self.restaurant_id = restaurant_id
        self.myRating = myRating
        self.notes = notes
        self.stamped = stamped
    }
    
    @discardableResult convenience init?(_ representation: ReviewRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let stamped = representation.stamped,
            let myRating = representation.myRating else { return nil }
        
        self.init(id: id!, user_id: user_id!, restaurant_id: restaurant_id!, myRating: myRating, stamped: stamped, context: context)
    }
}
