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
    
    weak var delegate: ViewApplicantCellDelegate?
    
    func readUser() {
        guard let uid = personInfoAsString else { return }
        FirestoreClient.shared.fetchFromFirestore(uuid: uid) { (user: User?) in
            guard let user = user else { return }
            self.user = user
        }
    }
    
    var personInfoAsString: String? {
        didSet {
            readUser()
        }
    }
    
    var user: User? {
        didSet {
            updateViewsCell()
        }
    }
    
    func updateViewsCell() {
        guard let user = user else {return}
        
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        applicantImage.image = user.pictureAsImage
        
        if user.reviewCount != 0{
            let rating = user.starCount / user.reviewCount
            switch rating {
            case 1:
                starOneLabel.text = Stars.one
            case 2:
                starOneLabel.text = Stars.two
            case 3:
                starOneLabel.text = Stars.three
            case 4:
                starOneLabel.text = Stars.four
            case 5:
                starOneLabel.text = Stars.five
            default:
                starOneLabel.text = Stars.zero
            }
        } else{
            starOneLabel.text = Stars.zero
        }
        
    }
    
    // TODO: - REFACTOR BASED ON HOW TO PASS DATA ALONG
    
    @IBAction func hireButton(_ sender: Any) {
        delegate?.hireButtonTapped()
        let vc = PostedDetailVC()
        guard let job = vc.selectedJob else { return }
        guard let user = user else { return }
        JobController.shared.accept(userFor: job, user: user)
        
    }
    
}
