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
    
    var reviewerRef: String // Reference
    var revieweeRef: String // Ref
    
    init(rating: Int, description: String, reviewerRef: String, ref revieweeRef: String) {
        self.rating = rating
        self.description = description
        self.reviewerRef = reviewerRef
        self.revieweeRef = revieweeRef
    }
    
}
