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
    let currentUser = UserController.shared.currentUser
    let uuid = UserController.shared.currentUser?.uuid
    let jobCollection = UserController.db.collection("jobs")
    let userRef = UserController.shared.userRef
    
    func createNewJob(title: String, description: String, category: String, pay: Int, address: Address, toolsNeeded: String?, toolsProvided: String?) {
        
        guard let userID = uuid else { return }
        guard let currentUser = currentUser else { return }
        
        let newJob = Job(title: title, description: description, pay: pay, address: address, toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, employerRef: userID)
        
        let values = ["title" : title,
                      "description" : description,
                      "category" : category,
                      "pay" : pay,
                      "address" : address,
                      "toolsNeeded" : toolsNeeded ?? "",
                      "toolsProvided" : toolsProvided ?? "",
                      "employerRef" : userID,
                      "applicantsRef" : [""],
                      "chosenOneRef" : "",
                      "ReviewOfJobPoster" : "",
                      "ReviewOfJobApplicant" : ""] as [String : Any]
        
        jobCollection.document(newJob.uuid).setData(values)

        
        currentUser.jobsCreated.append(newJob.uuid)
    }
    
    func applyToJob(job: Job) {
        guard let uuid = uuid else { return }
        let jobID = job.uuid
        guard var jobsApplied = currentUser?.jobsApplied else { return }
        jobsApplied.append(jobID)
        let newJobsApplied = jobsApplied

        job.applicantsRef.append(uuid)
        userRef.document(uuid).updateData(["jobsApplied" : newJobsApplied])
        jobCollection.document(jobID).updateData(["applicantsRef" : job.applicantsRef])
    }
    
    func updateJob(job: Job, title: String, description: String, category: String, pay: Int, address: Address, toolsNeeded: String?, toolsProvided: String?) {
        
        guard let userID = uuid else { return }
        
        job.title = title
        job.description = description
        job.category = category
        job.pay = pay
        job.address = address
        job.toolsNeeded = toolsNeeded
        job.toolsProvided = toolsProvided
        
        let values = ["title" : job.title,
                      "description" : job.description,
                      "category" : job.category,
                      "pay" : job.pay,
                      "address" : job.address,
                      "toolsNeeded" : job.toolsNeeded ?? "",
                      "toolsProvided" : job.toolsProvided ?? "",
                      "employerRef" : userID,
                      "applicantsRef" : job.applicantsRef,
                      "chosenOneRef" : job.chosenOneRef ?? "",
                      "ReviewOfEmployer" : job.reviewOfEmployer ?? "",
                      "ReviewOfWorker" : job.reviewOfWorker ?? ""] as [String : Any]
        
        jobCollection.document(job.uuid).updateData(values)
    }
    
    func accept(userFor job: Job, user: User) {
        
        job.chosenOneRef = user.uuid
        guard let chosenOneRef = job.chosenOneRef else { return }
        
        job.applicantsRef = ["Job already accepted"]
        let values = ["applicantsRef" : job.applicantsRef,
                      "chosenOneRef" : chosenOneRef] as [String : Any]
        
        jobCollection.document(job.uuid).updateData(values)
    }
    
    func deleteJob(job: Job) {
        jobCollection.document(job.uuid).delete()
        // might need to do additional work, such as updaing the array of jobsCreated in the user, and or updating the applicants jobs applied to. Not even sure if there needs to be a delete function for jobs, not putting more work into it for now.
    }
}

