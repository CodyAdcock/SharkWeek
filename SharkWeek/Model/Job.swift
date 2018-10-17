//
//  Job.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class Job{

    var title: String
    var description: String
    var category: String
    var pay: Int
    var line1: String
    var line2: String?
    var city: String
    var state: String
    var zipCode: String
    var toolsNeeded: String?
    var toolsProvided: String?
    var reviewOfEmployer: Review?
    var reviewOfWorker: Review?
    let uuid: String
    
    var employerRef: String //Reference
    var applicantsRef: [String] //Ref
    //check back in here CODY to make sure this is optional in the init
    var chosenOneRef: String? //Ref

    init(title: String, description: String, category: String = "Other", pay: Int, toolsNeeded: String?, toolsProvided: String?, employerRef: String, applicantsRef: [String] = [], chosenOneRef: String? = "", uuid: String = UUID().uuidString, line1: String, line2: String? = "", city: String, state: String, zipCode: String){
        
        self.title = title
        self.description = description
        self.category = category
        self.pay = pay
        self.toolsNeeded = toolsNeeded
        self.toolsProvided = toolsProvided
        self.employerRef = employerRef
        self.employerRef = employerRef
        self.applicantsRef = applicantsRef
        self.chosenOneRef = chosenOneRef
        self.uuid = uuid
        
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
