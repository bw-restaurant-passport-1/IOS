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
    // MARK: - Properties
    static let shared = CoreDataStack()

    private init() {

    }

    lazy var container: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Restaurant")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Core data was unable to load persistence stores: \(error)")
            }
        })

        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    var backgroundContext: NSManagedObjectContext {
        return container.newBackgroundContext()
    }
    
   //  MARK: - Methods
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("error saving context: \(error)")
                context.reset()
            }
        }
    }
 }
