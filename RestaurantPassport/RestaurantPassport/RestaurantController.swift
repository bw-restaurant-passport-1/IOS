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
    var restaurantList: [RestaurantRepresentation] = []
    //    var restaurant: Restaurant?
    
    // MARK: - Methods
    func get(completion: @escaping () -> Void = { }) {
        
        let base = URL(string: "https://restaurant-passport1.herokuapp.com/api/restaurants")!
        
        let requestURL = base
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error GETting restaurants: \(error)")
                completion()
                return
                
                do {
                    request.httpBody = try JSONDecoder().decode(RestaurantRepresentation.self, from: data!)
                } catch {
                    NSLog("Error decoding restaurant list: \(error)")
                    completion()
                    return
                }
            }
            completion()
        }.resume()
    }
    
    func put(restaurant: Restaurant, completion: @escaping () -> Void = { }) {
        
        let base = URL(string: "https://restaurant-passport1.herokuapp.com/api/restaurants")!
        
        let identifier = restaurant.id ?? UUID().uuidString
        restaurant.id = identifier
        
        let requestURL = base
            .appendingPathComponent(identifier)
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
        
        let identifiersToFetch = representations.compactMap({ $0.id })
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
                        let representation = representationsByID[identifier] else { continue }
                    
                    restaurant.restaurantName = representation.restaurantName
                    restaurant.id = representation.id
                    restaurantsToCreate.removeValue(forKey: identifier)
                }
                
                for representation in restaurantsToCreate.values {
                    Restaurant(representation, context: context)
                }
                
                CoreDataStack.shared.save(context: context)
                
            } catch {
                NSLog("Error fetching restaurants from persistent store: \(error)")
            }
        }
    }
    
    func deleteRestaurantFromServer(restaurant: Restaurant, completion: @escaping (Error?) -> Void ) {
        
        guard let identifier = restaurant.id else {return}
        
        let requestURL = base
            .appendingPathComponent(identifier)
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
        let id = UUID().uuidString
        let restaurant = Restaurant(id: id, restaurantName: restaurantName, streetAddress: streetAddress, city: city, zipcode: zipcode, phoneNumber: phoneNumber, websiteURL: websiteURL, restaurantPictureURL: restaurantPictureURL)
        
        let context = CoreDataStack.shared.mainContext
        
        CoreDataStack.shared.save(context: context)
        
        put(restaurant: restaurant!)
    }
    
    func delete(restaurant: Restaurant){
        
        let context = CoreDataStack.shared.mainContext
        
        context.performAndWait {
            deleteRestaurantFromServer(restaurant: restaurant) { (error) in
                NSLog("Error deleting restaurant")
            }
            context.delete(restaurant)
            CoreDataStack.shared.save()
        }
    }
}
