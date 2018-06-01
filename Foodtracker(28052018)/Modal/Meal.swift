//
//  Meal.swift
//  Foodtracker(28052018)
//
//  Created by quoccuong on 2018/05/29.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit
import os.log

class Meal {
    
    var name: String
    var photo: UIImage?
    var rating: Int

    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else { return nil }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
