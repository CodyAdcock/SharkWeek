//
//  ReviewController.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class ReviewController{
    
    let currentUser = UserController.shared.currentUser
    
    func addReviewForEmployer(job: Job, rating: Int, description: String) {
        
        guard let currentUser = currentUser else { return }
        let review = Review(rating: rating, description: description, workerRef: currentUser.uuid, employerRef: job.employerRef)
        job.reviewOfEmployer = review
        
    }
    
    func addReviewForWorker(job: Job, rating: Int, description: String) {
        
        guard let currentUser = currentUser else { return }
        guard let chosenOneRef = job.chosenOneRef else { return }
        let review = Review(rating: rating, description: description, workerRef: chosenOneRef, employerRef: currentUser.uuid)
        job.reviewOfWorker = review
        
    
    }
}
