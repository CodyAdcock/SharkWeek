//
//  JobController.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class JobController {
    
    let db = UserController.db
    let currentUser = UserController.shared.currentUser
    let uuid = UserController.shared.currentUser?.uuid
    let jobCollection = UserController.db.collection("jobs")
    let userRef = UserController.shared.userRef
    
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
    
    func acceptApplicantFor(job: Job, user: User) {
    
    }
    
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
}

