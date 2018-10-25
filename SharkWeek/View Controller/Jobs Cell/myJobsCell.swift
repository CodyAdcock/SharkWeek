//
//  myJobsCell.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

protocol myJobsCellDelegate: class{
    func doneButtonTapped(jobRef: String)
}

class myJobsCell: UITableViewCell {

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: myJobsCellDelegate?
    
    var myJob: Job? {
        didSet {
            updateViewsCell()
            
        }
    }
    
    func updateViewsCell() {
        guard let myJobs = myJob else {return}
        jobTitleLabel.text = myJobs.title
        payLabel.text = "$\(myJobs.pay)"
        descriptionLabel.text = myJobs.description
        if MyJobsTVC.segment == 0{
            doneButton.isHidden = false
        }else{
            doneButton.isHidden = true
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let jobRef = myJob?.uuid else {return}
        delegate?.doneButtonTapped(jobRef: jobRef)
    }
}
