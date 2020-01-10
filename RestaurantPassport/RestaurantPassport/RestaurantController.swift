//
//  RestaurantController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class RestaurantController {
    // MARK: - Properties
    // Database
    private let base = URL(string: "https://restaurant-passport1.herokuapp.com/api/restaurants")!
    
    // Restaurant Array
    var searchedRestaurants: [RestaurantRepresentation] = []
    
    // MARK: - Methods
    /* For future implementation of stretch goal
     func searchForRestaurant(with searchTerm: String, completion: @escaping (Error?) -> Void) {
     
     var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
     let queryParameters = ["query": searchTerm,
     "api_key": apiKey]
     
     components?.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
     
     guard let requestURL = components?.url else {
     completion(NSError())
     return
     }
     
     URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
     
     if let error = error {
     NSLog("Error searching for restaurant with search term \(searchTerm): \(error)")
     completion(error)
     return
     }
     
     guard let data = data else {
     NSLog("No data returned from data task")
     completion(NSError())
     return
     }
     
     do {
     let restaurantRepresentations = try JSONDecoder().decode(RestaurantRepresentations.self, from: data).results
     self.searchedRestaurants = restaurantRepresentations
     completion(nil)
     } catch {
     NSLog("Error decoding JSON data: \(error)")
     completion(error)
     }
     }.resume()
     }
     */
    
    
    
    func put(restaurant: Restaurant, completion: @escaping () -> Void = { }) {
        
        let base = URL(string: "https://restaurant-passport.firebaseio.com")!
        
        let identifier = restaurant.id ?? UUID()
        restaurant.id = identifier
        
        let requestURL = base
            .appendingPathComponent(identifier.uuidString)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        guard let restaurantRepresentation = restaurant.restaurantRepresentation else {
            NSLog("Restaurant Representation is nil")
            completion()
            return
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(restaurantRepresentation)
        } catch {
            NSLog("Error encoding restaurant representation: \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            
            if let error = error {
                NSLog("Error PUTting restaurant: \(error)")
                completion()
                return
            }
            
            completion()
        }.resume()
    }
    
    
    func updateRestaurant(with representations: [RestaurantRepresentation]) {
        
        let identifiersToFetch = representations.compactMap({ $0.id?.uuidString })
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        let context = CoreDataStack.shared.backgroundContext
        
        var restaurantsToCreate = representationsByID
        context.performAndWait {
            
            do {
                let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
                
                let existingRestaurants = try context.fetch(fetchRequest)
                
                for restaurant in existingRestaurants {
                    guard let identifier = restaurant.id,
                        let representation = representationsByID[identifier.uuidString] else { continue }
                    
                    restaurant.restaurantName = representation.restaurantName
                    restaurant.id = representation.id
                    restaurantsToCreate.removeValue(forKey: identifier.uuidString)
                }
                
                for representation in restaurantsToCreate.values {
                    Restaurant(representation, context: context)
                }
                
                CoreDataStack.shared.save(context: context)
                
            } catch {
                NSLog("Error fetching tasks from persistent store: \(error)")
            }
        }
    }
    
    func deleteEntryFromServer(restaurant: Restaurant, completion: @escaping (Error?) -> Void ) {
        
        guard let identifier = restaurant.id else {return}
        
        let requestURL = base
            .appendingPathComponent(identifier.uuidString)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting restaurant: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func createRestaurant(with restaurantName: String?, streetAddress: String?, city: String?, zipcode: String?, phoneNumber: String?, websiteURL: String?, restaurantPictureURL: String?) {
        let id = UUID()
        let restaurant = Restaurant(id: id, restaurantName: restaurantName, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, restaurantPictureURL: restaurantPictureURL)
        
        let context = CoreDataStack.shared.backgroundContext
        
        CoreDataStack.shared.save(context: context)
        
        put(restaurant: restaurant!)
        
    }
    
    func delete(restaurant: Restaurant){
        
        let context = CoreDataStack.shared.mainContext
        
        context.performAndWait {
            deleteEntryFromServer(restaurant: restaurant) { (error) in
                NSLog("Error deleting restaurant")
            }
            context.delete(restaurant)
            CoreDataStack.shared.save()
        }
    }
}
