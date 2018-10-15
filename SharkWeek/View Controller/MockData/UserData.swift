//
//  Users.swift
//  SharkWeek
//
//  Created by Sam on 10/14/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

struct UserData {
    
    static let shared = UserData()
    
    let john = User(firstName: "John", lastName: "Smith", email: "testing1@gmail.com", age: 25, address: AddressData.shared.johnsAddress, bio: "Busy family man, with never enough time to do work around the house", skill: "Planning", phoneNumber: "646-509-4375", picture: UIImage(named: "shark")!, uuid: "637916482648")
    
    let job1Applied = Job(title: "Lawnmowing at the getty", description: "This is a lawnmowing job", category: "Lawnmowing", pay: 50, address: AddressData.shared.gettyAddress, toolsNeeded: "Gloves", toolsProvided: "Lawnmower", employerRef: "5617148591", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: nil, uuid: "2356237562834729357")
    
    let job2Applied = Job(title: "Lawnmowing at the rialto", description: "This is a lawnmowing job", category: "Lawnmowing", pay: 50, address: AddressData.shared.rialtoAddress, toolsNeeded: "Gloves", toolsProvided: "Lawnmower", employerRef: "5617148591", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: nil, uuid: "2356237562834729357")
    
    let job3Applied = Job(title: "Emergency mopping at barbacoa", description: "There has been an epidemic and mopping is needed ASAP", category: "Mopping", pay: 50, address: AddressData.shared.barbacoaAddress, toolsNeeded: "Gloves", toolsProvided: "Mop and cleaner", employerRef: "5617148591", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: nil, uuid: "2356237562834729357")
    
    let job4Applied = Job(title: "Food truck cashier", description: "Our cashier called out sick, need one ASAP", category: "cashier", pay: 50, address: AddressData.shared.foodTruck, toolsNeeded: nil, toolsProvided: "Cash register", employerRef: "5617148591", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: nil, uuid: "2356237562834729357")

    
    let job1Completed = Job(title: "lawnmowing for sheila", description: "Lawnmowing job with decent pay", category: "Lawnmowing", pay: 25, address: AddressData.shared.johnsAddress, toolsNeeded: nil, toolsProvided: "Lawnmower", employerRef: "343246278364872364", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: UserData.shared.john.uuid, uuid: "23468726486234")
     let job2Completed = Job(title: "lawnmowing for sheila", description: "Lawnmowing job with decent pay", category: "Lawnmowing", pay: 25, address: AddressData.shared.johnsAddress, toolsNeeded: nil, toolsProvided: "Lawnmower", employerRef: "343246278364872364", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: UserData.shared.john.uuid, uuid: "23468726486234")
     let job3Completed = Job(title: "lawnmowing for sheila", description: "Lawnmowing job with decent pay", category: "Lawnmowing", pay: 25, address: AddressData.shared.johnsAddress, toolsNeeded: nil, toolsProvided: "Lawnmower", employerRef: "343246278364872364", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: UserData.shared.john.uuid, uuid: "23468726486234")
     let job4Completed = Job(title: "lawnmowing for sheila", description: "Lawnmowing job with decent pay", category: "Lawnmowing", pay: 25, address: AddressData.shared.johnsAddress, toolsNeeded: nil, toolsProvided: "Lawnmower", employerRef: "343246278364872364", applicantsRef: [UserData.shared.john.uuid], chosenOneRef: UserData.shared.john.uuid, uuid: "23468726486234")
    
}

