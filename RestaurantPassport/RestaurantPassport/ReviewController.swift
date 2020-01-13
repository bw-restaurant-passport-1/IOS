//
//  ReviewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 1/6/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation
import CoreData

class ReviewController {
    // MARK: - Properties
    // Database
    private let base = URL(string: "https://restaurant-passport1.herokuapp.com/api/passports")!
    
    // Restaurant Array
    var reviewedRestaurants: [ReviewRepresentation] = []
    
    // MARK: - Methods
    
    
    func put(review: Review, completion: @escaping () -> Void = { }) {
        
        let base = URL(string: "https://restaurant-passport1.herokuapp.com/api/passports")!
        
        let identifier = review.id ?? UUID().uuidString
        review.id = identifier
        
        let requestURL = base
            .appendingPathComponent(identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        guard let reviewRepresentation = review.reviewRepresentation else {
            NSLog("Review Representation is nil")
            completion()
            return
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(reviewRepresentation)
        } catch {
            NSLog("Error encoding review representation: \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            
            if let error = error {
                NSLog("Error PUTting review: \(error)")
                completion()
                return
            }
            
            completion()
        }.resume()
    }
    
    
    func updateReview(with representations: [ReviewRepresentation]) {
        
        let identifiersToFetch = representations.compactMap({ $0.id})
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        let context = CoreDataStack.shared.backgroundContext
        
        var reviewsToCreate = representationsByID
        context.performAndWait {
            
            do {
                let fetchRequest: NSFetchRequest<Review> = Review.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
                
                let existingReviews = try context.fetch(fetchRequest)
                
                for review in existingReviews {
                    guard let identifier = review.id,
                        let representation = representationsByID[identifier] else { continue }
                    
                    review.id = representation.id
                    review.user_id = representation.user_id
                    review.restaurant_id = representation.restaurant_id
                    review.stamped = representation.stamped!
                    review.notes = representation.notes
                    review.myRating = representation.myRating
                    reviewsToCreate.removeValue(forKey: identifier)
                }
                
                for representation in reviewsToCreate.values {
                    Review(representation, context: context)
                }
                
                CoreDataStack.shared.save(context: context)
                
            } catch {
                NSLog("Error fetching reviews from persistent store: \(error)")
            }
        }
    }
    
    func deleteReviewFromServer(review: Review, completion: @escaping (Error?) -> Void ) {
        
        guard let identifier = review.id else {return}
        
        let requestURL = base
            .appendingPathComponent(identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting review: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func createReview(with id: String, restaurant_id: String, myrating: String?, notes: String?, stamped: Bool?) {
        
        // TOFIX: - User ID
        let user_id = ""
        let review = Review(id: id, user_id: user_id, restaurant_id: restaurant_id,
                            myRating: myrating,
                            notes: notes,
                            stamped: stamped)
        
        let context = CoreDataStack.shared.backgroundContext
        
        CoreDataStack.shared.save(context: context)
        
        put(review: review!)
        
    }
    
    func visitRestaurant(review: Review, restaurant: Restaurant, stamped: Bool) {
        
        review.restaurant_id = restaurant.id?.uuidString
        review.stamped = stamped
        CoreDataStack.shared.save()
        put(review: review)
    }
    
    func rateRestaurant(review: Review, restaurant: Restaurant, myRating: String) {
        
        review.restaurant_id = restaurant.id?.uuidString
        review.myRating = myRating
        CoreDataStack.shared.save()
        put(review: review)
    }
    
    func delete(review: Review){
        
        let context = CoreDataStack.shared.mainContext
        
        context.performAndWait {
            deleteReviewFromServer(review: review) { (error) in
                NSLog("Error deleting review")
            }
            context.delete(review)
            CoreDataStack.shared.save()
        }
    }
}
