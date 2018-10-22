//
//  ReviewController.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class ReviewController{
    
    var user: User?
    
    static let shared = ReviewController()
    let currentUser = UserController.shared.currentUser
    
    let db = UserController.db
    let jobCollection = UserController.db.collection("jobs")
    let userCollection = UserController.db.collection("users")
    
    
    
    func addReviewForEmployer(job: Job, rating: Int, description: String) {
        
        //create review and add to firebase
        guard let currentUser = currentUser else { return }
        let review = Review(rating: rating, description: description, workerRef: currentUser.uuid, employerRef: job.employerRef)
        job.reviewOfEmployer = review
        jobCollection.document(job.uuid).updateData(["ReviewOfEmployer" : review])
        
        // grab the employer
        userCollection.document(review.employerRef).getDocument { (querySnapshot, error) in
            if let error = error {
                print("There was an error reading document \(error.localizedDescription)")
            }
            guard let querySnapshot = querySnapshot,
                let dictionary = querySnapshot.data() else { return }
            self.user = User(with: dictionary, id: job.employerRef)
        }
        
        guard let user = user else {return}
        
        //add number of reviews and stars to the user and update firebase
        user.reviewCount += 1
        user.starCount += rating
        let values = ["reviewCount": user.starCount,"starCount": user.reviewCount]
        userCollection.document(job.employerRef).updateData(values)
        
        
        
    }
    
    func addReviewForWorker(job: Job, rating: Int, description: String) {
        
        guard let currentUser = currentUser else { return }
        guard let chosenOneRef = job.chosenOneRef else { return }
        let review = Review(rating: rating, description: description, workerRef: chosenOneRef, employerRef: currentUser.uuid)
        job.reviewOfWorker = review
        
        jobCollection.document(job.uuid).updateData(["ReviewOfWorker" : review])
        
        // grab the worker
        userCollection.document(review.workerRef).getDocument { (querySnapshot, error) in
            if let error = error {
                print("There was an error reading document \(error.localizedDescription)")
            }
            guard let querySnapshot = querySnapshot,
                let dictionary = querySnapshot.data() else { return }
            self.user = User(with: dictionary, id: review.workerRef)
        }
        
        guard let user = user else {return}
        
        //add number of reviews and stars to the user and update firebase
        user.reviewCount += 1
        user.starCount += rating
        let values = ["reviewCount": user.starCount,"starCount": user.reviewCount]
        userCollection.document(review.workerRef).updateData(values)
        
    }
}
