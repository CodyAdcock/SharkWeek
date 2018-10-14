//
//  File.swift
//  SharkWeek
//
//  Created by Sam on 10/14/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class JobData {
    
    let jobsAppliedArray = [UserData.shared.job1Applied, UserData.shared.job2Applied, UserData.shared.job3Applied, UserData.shared.job4Applied]
    
    let jobsHiredCompletedArray = [UserData.shared.job1Completed, UserData.shared.job2Completed, UserData.shared.job3Completed, UserData.shared.job4Completed]
    
    let jobsCreatedCompletedArray = [UserData.shared.job1Completed, UserData.shared.job2Completed]
    
    let jobsInProgressArray = [UserData.shared.job1Applied, UserData.shared.job2Applied]
    
    let jobsCreatedArray = [UserData.shared.job1Completed, UserData.shared.job4Applied]
}
