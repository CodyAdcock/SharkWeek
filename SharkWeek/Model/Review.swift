//
//  Review.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class Review{
    
    var rating: Int
    var description: String
    
    var workerRef: String // Reference
    var employerRef: String // Ref
    
    init(rating: Int, description: String, workerRef: String, employerRef: String) {
        self.rating = rating
        self.description = description
        self.workerRef = workerRef
        self.employerRef = employerRef
    }
}
