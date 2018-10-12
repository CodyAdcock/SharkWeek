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
    var address: Address
    var toolsNeeded: String?
    var toolsProvided: String?
    var reviewOfEmployer: Review?
    var reviewOfWorker: Review?
    let uuid: String
    
    var employerRef: String //Reference
    var applicantsRef: [String] //Ref
    //check back in here CODY to make sure this is optional in the init
    var chosenOneRef: String? //Ref

    init(title: String, description: String, category: String = "Other", pay: Int, address: Address, toolsNeeded: String?, toolsProvided: String?, employerRef: String, applicantsRef: [String] = [], chosenOneRef: String? = "", uuid: String = UUID().uuidString){
        
        self.title = title
        self.description = description
        self.category = category
        self.pay = pay
        self.address = address
        self.toolsNeeded = toolsNeeded
        self.toolsProvided = toolsProvided
        self.employerRef = employerRef
        self.employerRef = employerRef
        self.applicantsRef = applicantsRef
        self.chosenOneRef = chosenOneRef
        self.uuid = uuid
    }
}
