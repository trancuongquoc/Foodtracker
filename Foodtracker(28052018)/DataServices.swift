//
//  DataServices.swift
//  Foodtracker(28052018)
//
//  Created by quocuong on 5/31/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

class DataServices {
    
    static let shared = DataServices()
    
    private var _meals: [Meal]?
    
    var meals: [Meal] {
        get {
            if _meals == nil {
                updateMeals()
            }
            return _meals ?? []
        }
    }
    
    fileprivate func updateMeals() {
        _meals = []
        _meals = loadSampleMeals()
    }
    
    func editMeal(at indexPath: IndexPath, with name: String, with photo: UIImage, with rating: Int) {
        _meals?[indexPath.row].name = name
        _meals?[indexPath.row].photo = photo
        _meals?[indexPath.row].rating = rating
    }
    
     func addNew(with meal: Meal) {
        _meals?.append(meal)
    }
    
    func removeMeal(at indexPath: IndexPath) {
        _meals?.remove(at: indexPath.row)
    }
    private func loadSampleMeals() -> [Meal] {
        var meals = [Meal]()
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Fucking Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Shitty potatoes", photo: photo2, rating: 2) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal3 = Meal(name: "Pasta", photo: photo3, rating: 1) else {
            fatalError("Unable to instantiate meal1")
        }
        
        meals += [meal1, meal2, meal3]
        return meals
    }
}
