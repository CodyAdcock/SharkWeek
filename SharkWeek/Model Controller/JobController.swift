//
//  JobController.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
class JobController {
    
    static let shared = JobController()
    
    let db = UserController.db
    
    let jobCollection = UserController.db.collection("jobs")
    let userCollection = UserController.db.collection("users")
    let userRef = UserController.shared.userRef
    
    
    func createNewJob(title: String, description: String, category: String, pay: Int, toolsNeeded: String?, toolsProvided: String?, line1: String, line2: String?, city: String, state: String, zipCode: String) {
        
        guard let userID = UserController.shared.currentUser?.uuid else { return }
        guard let currentUser = UserController.shared.currentUser else { return }
        
        let newJob = Job(title: title, description: description, pay: pay, toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, employerRef: userID, line1: line1, line2: line2, city: city, state: state, zipCode: zipCode)
        
        let values = ["title" : title,
                      "uuid" : newJob.uuid,
                      "description" : description,
                      "category" : category,
                      "pay" : pay,
                      "line1" : line1,
                      "line2" : line2 ?? "",
                      "city" : city,
                      "state" : state,
                      "zipCode" : zipCode,
                      "toolsNeeded" : toolsNeeded ?? "",
                      "toolsProvided" : toolsProvided ?? "",
                      "employerRef" : userID,
                      "applicantsRef" : [],
                      "chosenOneRef" : "",
                      "ReviewOfJobPoster" : "",
                      "ReviewOfJobApplicant" : ""] as [String : Any]
        
        jobCollection.document(newJob.uuid).setData(values)
        
        
        currentUser.jobsCreated.append(newJob.uuid)
        
        userRef.document(currentUser.uuid).updateData([
            "jobsCreated" : currentUser.jobsCreated
            ])
        
    }
    
    // TODO: - Fix this (memory leak)
    
    
    func readOneJob(with jobReference: String, completion: @escaping (Job?) -> Void) {
        jobCollection.document(jobReference).getDocument { (DocumentSnapshot, error) in
            
            if let error = error {
                print("there was an error getting the job document for \(jobReference) error: \(error.localizedDescription)")
                return
            }
            
//            guard let uuid = self.uuid else { return }
            guard let documentSnapshot = DocumentSnapshot else { return }
            guard let title = documentSnapshot.get("title") as? String else { return }
            guard let description = documentSnapshot.get("description") as? String else { return }
            
            guard let category = documentSnapshot.get("category") as? String else { return }
            
            guard let pay = documentSnapshot.get("pay") as? Int else { return }
            
            guard let toolsNeeded = documentSnapshot.get("toolsNeeded") as? String else { return }
            
            guard let toolsProvided = documentSnapshot.get("toolsProvided") as? String else { return }
            
            guard let employerRef = documentSnapshot.get("employerRef") as? String else { return }
            
            guard let applicantsRef = documentSnapshot.get("applicantsRef") as? [String] else { return }
            
            guard let chosenOneRef = documentSnapshot.get("chosenOneRef") as? String else { return }
            guard let line1 = documentSnapshot.get("line1") as? String,
                let city = documentSnapshot.get("city") as? String,
                let state = documentSnapshot.get("state") as? String,
                let zipCode = documentSnapshot.get("zipCode") as? String else { return }
            
            let line2 = documentSnapshot.get("line2") as? String
            //                        guard let reviewOfJobPoster = documentSnapshot.get("ReviewOfJobPoster") as? String else { return }
            //                        guard let reviewOfJobApplicant = documentSnapshot.get("ReviewOfJobApplicant") as? String else { return }
            
            
            let jobA = Job(title: title, description: description, category: category, pay: pay, toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, employerRef: employerRef, applicantsRef: applicantsRef, chosenOneRef: chosenOneRef, uuid: jobReference, line1: line1, line2: line2, city: city, state: state, zipCode: zipCode)
            //                jobA.reviewOfWorker = reviewOfJobApplicant
            //                jobA.reviewOfEmployer = reviewOfJobPoster
            completion(jobA)

        }
        
    }
    
    
    func applyToJob(job: Job) {
        guard let uuid = UserController.shared.currentUser?.uuid else { return }
        let jobID = job.uuid
        guard var jobsApplied = UserController.shared.currentUser?.jobsApplied else { return }
        jobsApplied.append(jobID)
        let newJobsApplied = jobsApplied
        
        job.applicantsRef.append(uuid)
        userRef.document(uuid).updateData(["jobsApplied" : newJobsApplied])
        jobCollection.document(jobID).updateData(["applicantsRef" : job.applicantsRef])
    }
    
    
    func updateJob(job: Job, title: String, description: String, category: String, pay: Int, toolsNeeded: String?, toolsProvided: String?, line1: String, line2: String?, city: String, state: String, zipCode: String) {
        
        guard let userID = UserController.shared.currentUser?.uuid else { return }
        
        job.title = title
        job.description = description
        job.category = category
        job.pay = pay
        job.toolsNeeded = toolsNeeded
        job.toolsProvided = toolsProvided
        job.line1 = line1
        job.line2 = line2
        job.city = city
        job.state = state
        job.zipCode = zipCode
        
        let values = ["title" : job.title,
                      "description" : job.description,
                      "category" : job.category,
                      "pay" : job.pay,
                      "line1" : line1,
                      "line2" : line2 ?? "",
                      "city" : city,
                      "state" : state,
                      "zipCode" : zipCode,
                      "toolsNeeded" : job.toolsNeeded ?? "",
                      "toolsProvided" : job.toolsProvided ?? "",
                      "employerRef" : userID,
                      "applicantsRef" : job.applicantsRef,
                      "chosenOneRef" : job.chosenOneRef ?? "",
                      "ReviewOfEmployer" : job.reviewOfEmployer ?? "",
                      "ReviewOfWorker" : job.reviewOfWorker ?? ""] as [String : Any]
        
        jobCollection.document(job.uuid).updateData(values)
    }
    // TODO: update users applied jobs array 
    func accept(userFor job: Job, user: User) {
        
        job.chosenOneRef = user.uuid
        guard let currentUser = UserController.shared.currentUser else {return}
        currentUser.jobsInProgress.append(job.uuid)
        var thisCount = 0
        for jobRef in currentUser.jobsCreated{
            if jobRef == job.uuid{
                UserController.shared.currentUser?.jobsCreated.remove(at: thisCount)
                thisCount += 1
            }
        }
        let valuesEmployer = ["jobsInProgress" : currentUser.jobsInProgress, "jobsCreated" : currentUser.jobsCreated]
        
        userRef.document(currentUser.uuid).updateData(valuesEmployer)
        guard let chosenOneRef = job.chosenOneRef else { return }
        //bad
        for userRef in job.applicantsRef{
            FirestoreClient.shared.fetchFromFirestore(uuid: userRef) { (user: User?) in
                guard let jobsApplied = user?.jobsApplied else {return}
                var count = 0
                for ref in jobsApplied{
                    if ref == job.uuid{
                        user?.jobsApplied.remove(at: count)
                        guard let jApplied = user?.jobsApplied else {return}
                        let userValues = ["jobsApplied" : jApplied]
                        UserController.db.collection("users").document(userRef).updateData(userValues)
                    }
                    count += 1
                }
            }
        }
        
        job.applicantsRef = []
        let jobValues = ["applicantsRef" : job.applicantsRef,
                      "chosenOneRef" : chosenOneRef] as [String : Any]
        
        jobCollection.document(job.uuid).updateData(jobValues)
        
        user.jobsInProgress.append(job.uuid)
        let valuesUser = ["jobsInProgress" : user.jobsInProgress]
        
        userRef.document(user.uuid).updateData(valuesUser)
    }
    
    func completeJob(jobRef: String?){
        guard let jobRef = jobRef else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: jobRef) { (job: Job?) in
            guard let job = job else {return}
            guard let employeeRef = job.chosenOneRef else {return}
            FirestoreClient.shared.fetchFromFirestore(uuid: job.employerRef, completion: { (employer: User?) in
                guard let jobRefs = employer?.jobsInProgress else {return}
                var count = 0
                for jobRef in jobRefs{
                    if jobRef == job.uuid{
                        employer?.jobsInProgress.remove(at: count)
                    }
                    count += 1
                }
                employer?.jobsCreatedCompleted.append(job.uuid)
                guard let employer = employer else {return}
                let values = ["jobsInProgress" : employer.jobsInProgress, "jobsCreatedCompleted" : employer.jobsCreatedCompleted] as [String : Any]
                self.userCollection.document(employer.uuid).updateData(values)
            })
            FirestoreClient.shared.fetchFromFirestore(uuid: employeeRef, completion: { (employee: User?) in
                guard let jobRefs = employee?.jobsInProgress else {return}
                var count = 0
                for jobRef in jobRefs{
                    if jobRef == job.uuid{
                        employee?.jobsInProgress.remove(at: count)
                    }
                    count += 1
                }
                employee?.jobsHiredCompleted.append(job.uuid)
                guard let employee = employee else {return}
                let values = ["jobsInProgress" : employee.jobsInProgress, "jobsHiredCompleted" : employee.jobsHiredCompleted] as [String : Any]
                self.userCollection.document(employee.uuid).updateData(values)
            })
        }
    }
    
    func rateJob(jobRef: String, starCount: Int, description: String, employerRating: Bool){
        FirestoreClient.shared.fetchFromFirestore(uuid: jobRef) { (job: Job?) in
            guard let job = job else {return}
            guard let employeeRef = job.chosenOneRef else {return}
            let review = Review(rating: starCount, description: description, workerRef: employeeRef, employerRef: job.employerRef)
            job.reviewOfEmployer = review
            
            if employerRating{
                FirestoreClient.shared.fetchFromFirestore(uuid: job.employerRef, completion: { (user: User?) in
                    guard let user = user else {return}
                    user.reviewCount += 1
                    user.starCount += starCount
                    //let review = Review(rating: starCount, description: description, workerRef: employeeRef, employerRef: job.employerRef)
                    //job.reviewOfWorker = review
                    //let jobValues = ["ReviewOfJobPoster" : job.reviewOfWorker] as [String : Any]
                    //self.jobCollection.document(job.uuid).updateData(jobValues)
                    let userValues = ["reviewCount" : user.reviewCount, "starCount" : user.starCount] as [String : Any]
                    self.userCollection.document(user.uuid).updateData(userValues)
                })
            }else{
                FirestoreClient.shared.fetchFromFirestore(uuid: employeeRef, completion: { (user: User?) in
                    guard let user = user else {return}
                    user.reviewCount += 1
                    user.starCount += starCount
//                    let review = Review(rating: starCount, description: description, workerRef: employeeRef, employerRef: job.employerRef)
//                    job.reviewOfEmployer = review
//                    //let jobValues = ["ReviewOfJobApplicant" : job.reviewOfWorker] as [String : Any]
//                    self.jobCollection.document(job.uuid).updateData(jobValues)
                    let userValues = ["reviewCount" : user.reviewCount, "starCount" : user.starCount] as [String : Any]
                    self.userCollection.document(user.uuid).updateData(userValues)
                })
            }
        }
    }
    
    func deleteJob(job: Job) {
        jobCollection.document(job.uuid).delete()
        // might need to do additional work, such as updaing the array of jobsCreated in the user, and or updating the applicants jobs applied to. Not even sure if there needs to be a delete function for jobs, not putting more work into it for now.
    }
    func segmentChange(segment: Int){
        MyJobsTVC.segment = segment
    }
}

