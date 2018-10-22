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
        firstNameLabel.text = UserController.shared.currentUser?.firstName
        lastNameLabel.text = UserController.shared.currentUser?.lastName
        applicantImage.image = UserController.shared.currentUser?.pictureAsImage
        
        starOneLabel.text = Stars.one
        starTwoLabel.text = Stars.two
        starThreeLabel.text = Stars.three
        starFourLabel.text = Stars.four
        starFiveLabel.text = Stars.five
        
    }
  
    @IBAction func hireButton(_ sender: Any) {
        delegate?.hireButtonTapped()
    }
    
}
