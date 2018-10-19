//
//  ViewApplicantsCell.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

protocol ViewApplicantCellDelegate: class {
    func hireButtonTapped()
}

class ViewApplicantsCell: UITableViewCell {
   
    @IBOutlet weak var applicantImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var starOneLabel: UILabel!
    @IBOutlet weak var starTwoLabel: UILabel!
    @IBOutlet weak var starThreeLabel: UILabel!
    @IBOutlet weak var starFourLabel: UILabel!
    @IBOutlet weak var starFiveLabel: UILabel!
    
    weak var delegate: ViewApplicantCellDelegate?
    
    var personInfo: User? {
        didSet {
            updatePerson()
        }
    }
    func updatePerson() {
        guard let personInfo = personInfo else {return}
        firstNameLabel.text = personInfo.firstName
        lastNameLabel.text = personInfo.lastName
        applicantImage.image = personInfo.pictureAsImage
    }
    
    
    
    var jobApplicant: Job? {
        didSet {
            updateViews()
        }
    }
    func updateViews() {
        guard let jobApplicant = jobApplicant else {return}
        starOneLabel.text = "\(String(describing: jobApplicant.reviewOfWorker?.rating))"
        starTwoLabel.text = "\(String(describing: jobApplicant.reviewOfWorker?.rating))"
        starThreeLabel.text = "\(String(describing: jobApplicant.reviewOfWorker?.rating))"
        starFourLabel.text = "\(String(describing: jobApplicant.reviewOfWorker?.rating))"
        starFiveLabel.text = "\(String(describing: jobApplicant.reviewOfWorker?.rating))"
    }
    
    @IBAction func hireButton(_ sender: Any) {
        delegate?.hireButtonTapped()
    }
    
}
