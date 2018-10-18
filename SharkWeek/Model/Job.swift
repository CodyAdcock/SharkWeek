//
//  Job.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class Job: FirestoreFetchable {
    
    static let CollectionName: String = "jobs"
    
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
        self.applicantsRef = applicantsRef
        self.chosenOneRef = chosenOneRef
        self.uuid = uuid
        
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    
    required convenience init?(with dictionary: [String : Any], id: String) {
        
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let category = dictionary["category"] as? String,
            let pay = dictionary["pay"] as? Int,
            let uuid = dictionary["uuid"] as? String,
            let line1 = dictionary["line1"] as? String,
            let city = dictionary["city"] as? String,
            let state = dictionary["state"] as? String,
            let zipCode = dictionary["zipCode"] as? String,
            let applicantsRef = dictionary["applicantsRef"] as? [String],
            let chosenOneRef = dictionary["chosenOneRef"] as? String,
            let employerRef = dictionary["employerRef"] as? String else { return nil }
        
        let toolsNeeded = dictionary["toolsNeeded"] as? String
        let toolsProvided = dictionary["toolsProvided"] as? String
        let line2 = dictionary["line2"] as? String
        
        
        self.init(title: title, description: description, category: category, pay: pay,toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, employerRef: employerRef, applicantsRef: applicantsRef, chosenOneRef: chosenOneRef, uuid: uuid, line1: line1, line2: line2, city: city, state: state, zipCode: zipCode)
    }
    
}
