//
//  RestaurantTableViewController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {
    var restaurantController = RestaurantController()
    var reviewController = ReviewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        print(restaurantController.restaurantList.count)
//        let _ = Restaurant(id: UUID().uuidString, restaurantName: "Bobs", streetAddress: "123 Main St", city: "town", zipcode: "12345", phoneNumber: "123-4567", websiteURL: "www.website.com", restaurantPictureURL: "")
//    
//        let context = CoreDataStack.shared.mainContext
//        CoreDataStack.shared.save(context: context)
       
//        let context = CoreDataStack.shared.backgroundContext
//        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
//        
//        
//        let existingRestaurants = try! context.fetch(fetchRequest)
//        print(existingRestaurants.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
   // }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantController.restaurantList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        let displayedRestaurant = restaurantController.restaurantList[indexPath.item]
        let displayedReview = reviewController.reviewList[indexPath.item]
        cell.restaurant = displayedRestaurant
        cell.review = displayedReview
        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurantController.restaurantList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            if let addVC = segue.destination as? RestaurantDetailViewController {
                addVC.restaurantController = restaurantController
                addVC.reviewController = reviewController
            }
        } else if segue.identifier == "viewSegue" {
            if let viewVC = segue.destination as? RestaurantDetailViewController {
                viewVC.restaurantController = restaurantController
                viewVC.reviewController = reviewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    viewVC.restaurant = restaurantController.restaurantList[indexPath.row]
                    viewVC.review = reviewController.reviewList[indexPath.row]
                }
            }
        }
    }
}
