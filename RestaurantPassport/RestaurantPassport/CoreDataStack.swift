//
//  CoreDataStack.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RestaurantPassport" as String)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext { return container.viewContext }
}
