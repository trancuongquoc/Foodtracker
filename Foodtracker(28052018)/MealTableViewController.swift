//
//  MealTableViewController.swift
//  Foodtracker(28052018)
//
//  Created by quoccuong on 2018/05/29.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    var meals = DataServices.shared.meals
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("Some shitty errors")
        }
        
        cell.mealNameLabel.text = meals[indexPath.row].name
        cell.mealImageView.image = meals[indexPath.row].photo
        cell.ratingControl.rating = meals[indexPath.row].rating
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
//    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
//            
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                // Update an existing meal.
//                meals[selectedIndexPath.row] = meal
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            } else {
//                // Add a new meal.
//                let newIndexPath = IndexPath(row: meals.count, section: 0)
//                meals.append(meal)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
        }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            mealDetailViewController.indexPath = indexPath
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}
