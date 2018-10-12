//
//  User.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class User {
    
    var uuid: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var address: Address // Address has multiple properties so it's its own object
    var bio: String
    var skill: String
    var phoneNumber: String
    var reviewCount: Int
    var starCount: Int
    var picture: String
    var isMinor: Bool
    //Job Ref Arrays
    var jobsCreated: [String] // UUIDs of jobs
    var jobsCreatedCompleted: [String] // UUIDs of jobs
    var jobsApplied: [String] // UUIDs of jobs
    var jobsInProgress: [String] // UUIDs of jobs
    var jobsHiredCompleted: [String] // UUIDs of jobs
    
    init(firstName: String, lastName: String, email: String, age: Int, address: Address, bio: String, skill: String, phoneNumber: String, reviewCount: Int = 0, starCount: Int = 0,  picture: String, jobsCreated: [String] = [], jobsCreatedCompleted: [String] = [], jobsApplied: [String] = [], jobsInProgress: [String] = [], jobsHiredCompleted: [String] = [], uuid: String ){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.address = address
        self.bio = bio
        self.skill = skill
        self.phoneNumber = phoneNumber
        self.reviewCount = reviewCount
        self.starCount = starCount
        self.picture = picture
        self.isMinor = age < 18
        self.jobsCreated = jobsCreated
        self.jobsCreatedCompleted = jobsCreatedCompleted
        self.jobsApplied = jobsApplied
        self.jobsInProgress = jobsInProgress
        self.jobsHiredCompleted = jobsHiredCompleted
        self.uuid = uuid
    }
}

class Address {
    var line1: String
    var line2: String?
    var city: String
    var state: String
    var zipCode: String
    init(line1: String, line2: String? = "", city: String, state: String, zipCode: String) {
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
