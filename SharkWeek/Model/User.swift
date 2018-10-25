//
//  User.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class User: FirestoreFetchable {
    
    static let CollectionName: String = "users"
    
    var uuid: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var bio: String
    var skill: String
    var phoneNumber: String
    var reviewCount: Int
    var starCount: Int
    var pictureAsImage: UIImage?{
        didSet{
            print("Yo Picture Got Changed")
        }
    }
    var pictureAsString: String
    
    var blockedUsers: [String]
    
    //Job Ref Arrays
    var jobsCreated: [String] // UUIDs of jobs
    var jobsCreatedCompleted: [String] // UUIDs of jobs
    var jobsApplied: [String] // UUIDs of jobs
    var jobsInProgress: [String] // UUIDs of jobs
    var jobsHiredCompleted: [String] // UUIDs of jobs
    // Address properties
    var line1: String
    var line2: String?
    var city: String
    var state: String
    var zipCode: String
    
    var isMinor: Bool{
        return self.age < 18
    }
    
    init(firstName: String, lastName: String, email: String, age: Int, bio: String, skill: String, phoneNumber: String, reviewCount: Int = 0, starCount: Int = 0,  pictureAsString: String, jobsCreated: [String] = [], jobsCreatedCompleted: [String] = [], jobsApplied: [String] = [], jobsInProgress: [String] = [], jobsHiredCompleted: [String] = [], uuid: String, line1: String, line2: String? = "", city: String, state: String, zipCode: String, blockedUsers: [String] = []){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.bio = bio
        self.skill = skill
        self.phoneNumber = phoneNumber
        self.reviewCount = reviewCount
        self.starCount = starCount
        self.pictureAsString = pictureAsString
        self.jobsCreated = jobsCreated
        self.jobsCreatedCompleted = jobsCreatedCompleted
        self.jobsApplied = jobsApplied
        self.jobsInProgress = jobsInProgress
        self.jobsHiredCompleted = jobsHiredCompleted
        self.uuid = uuid
        self.blockedUsers = blockedUsers
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    
    convenience required init?(with dictionary: [String : Any], id: String) {
        
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let email = dictionary["email"] as? String,
            let age = dictionary["age"] as? Int,
            let bio = dictionary["bio"] as? String,
            let skill = dictionary["skill"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? String,
            let reviewCount = dictionary["reviewCount"] as? Int,
            let starCount = dictionary["starCount"] as? Int,
            let pictureAsString = dictionary["picture"] as? String,
            let jobsCreated = dictionary["jobsCreated"] as? [String],
            let jobsCreatedCompleted = dictionary["jobsCreatedCompleted"] as? [String],
            let jobsApplied = dictionary["jobsApplied"] as? [String],
            let jobsInProgress = dictionary["jobsInProgress"] as? [String],
            let jobsHiredCompleted = dictionary["jobsHiredCompleted"] as? [String],
            let line1 = dictionary["line1"] as? String,
            let city = dictionary["city"] as? String,
            let state = dictionary["state"] as? String,
            let blockedUsers = dictionary["blockedUsers"] as? [String],
            let zipCode = dictionary["zipCode"] as? String else { return nil}
        
        let line2 = dictionary["line2"] as? String
        
        self.init(firstName: firstName, lastName: lastName, email: email, age: age, bio: bio, skill: skill, phoneNumber: phoneNumber, reviewCount: reviewCount, starCount: starCount, pictureAsString: pictureAsString, jobsCreated: jobsCreated, jobsCreatedCompleted: jobsCreatedCompleted, jobsApplied: jobsApplied, jobsInProgress: jobsInProgress, jobsHiredCompleted: jobsHiredCompleted, uuid: id, line1: line1, line2: line2, city: city, state: state, zipCode: zipCode, blockedUsers: blockedUsers)
    }
}
