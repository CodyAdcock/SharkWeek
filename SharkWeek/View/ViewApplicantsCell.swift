//
//  ViewApplicantsCell.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

protocol ViewApplicantCellDelegate: class {
    func hireButtonTapped(cell: ViewApplicantsCell)
}

class ViewApplicantsCell: UITableViewCell {
    
    @IBOutlet weak var applicantImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var starOneLabel: UILabel!
    
    weak var delegate: ViewApplicantCellDelegate?
    
    
    var userRef: String? {
        didSet {
            updateViews()
        }
    }
    
    var rating: Int?{
        didSet{
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
        }
    }
    
    func updateViews() {
        guard let userRef = userRef else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: userRef) { (user: User?) in
            guard let user = user else {return}
            UserController.shared.grabUsersPicture(user: user) { (success) in
                if success == true {
                    self.applicantImage.image = user.pictureAsImage
                    print("sick, loaded picture")
                } else {
                    print("Could not set the value for the users image")
                }
            }
            self.firstNameLabel.text = "\(user.firstName) \(user.lastName)"
            if user.reviewCount == 0 {return}
            self.rating = user.starCount / user.reviewCount
        }
    }
    
    // TODO: - REFACTOR BASED ON HOW TO PASS DATA ALONG
    
    @IBAction func hireButton(_ sender: Any) {
        delegate?.hireButtonTapped(cell: self)
    }
    
}
