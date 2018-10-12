//
//  myJobsCell.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class myJobsCell: UITableViewCell {

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    var myJob: Job? {
        didSet {
            updateViewsCell1()
            updateViewsCell2()
            updateViewsCell3()
            updateViewsCell4()
        }
    }
    
    func updateViewsCell1() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "\(myJobs.pay)"
        descriptionTV.text = myJobs.description
    }
    
    func updateViewsCell2() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "\(myJobs.pay)"
        descriptionTV.text = myJobs.description
    }
    
    func updateViewsCell3() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "\(myJobs.pay)"
        descriptionTV.text = myJobs.description
    }
    
    func updateViewsCell4() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "\(myJobs.pay)"
        descriptionTV.text = myJobs.description
    }
}
