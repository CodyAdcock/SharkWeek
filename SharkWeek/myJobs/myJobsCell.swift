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
            updateViewsCell()
            
        }
    }
    
    func updateViewsCell() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "\(myJobs.pay)"
        descriptionTV.text = myJobs.description
    }
    
}
