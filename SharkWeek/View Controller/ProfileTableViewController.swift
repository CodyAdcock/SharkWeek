//
//  ProfileTableViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    //IBOutlets Main Page
    
    @IBOutlet weak var ProfilePictureImageView: UIImageView!
    @IBOutlet weak var NameAgeLabel: UILabel!
    @IBOutlet weak var CityStateLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var profileSegementedController: UISegmentedControl!

    //Container IBOutlets
    @IBOutlet weak var PersonalInfoContainer: UIView! //toPersonalInfoVC
    @IBOutlet weak var JobHistoryContainer: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.PersonalInfoContainer.isHidden = false
        self.PersonalInfoContainer.alpha = 1
        self.JobHistoryContainer.isHidden = true
        self.JobHistoryContainer.alpha = 0
        
        let currentUser = UserData.shared.john
        
        ProfilePictureImageView.image = UIImage(contentsOfFile: "blankFace")
        NameAgeLabel.text = "\(currentUser.firstName) \(currentUser.lastName), \(currentUser.age)"
        CityStateLabel.text = "\(currentUser.address.city), \(currentUser.address.state)"
        let rating = currentUser.starCount / currentUser.reviewCount
        switch rating {
        case 1:
            RatingLabel.text = Stars.one
        case 2:
            RatingLabel.text = Stars.two
        case 3:
            RatingLabel.text = Stars.three
        case 4:
            RatingLabel.text = Stars.four
        case 5:
            RatingLabel.text = Stars.five
        default:
            RatingLabel.text = "Rating Not Found"
        }
    }

    
    @IBAction func SegmentedControllerTapped(_ sender: Any) {
        switch profileSegementedController.selectedSegmentIndex{
        case 0:
            print("0")
            UIView.animate(withDuration: 0.25){
                self.PersonalInfoContainer.isHidden = false
                self.PersonalInfoContainer.alpha = 1
                self.JobHistoryContainer.alpha = 0
                self.JobHistoryContainer.isHidden = true
            }
        case 1:
            print("1")
            UIView.animate(withDuration: 0.25){
                self.PersonalInfoContainer.alpha = 0
                self.PersonalInfoContainer.isHidden = true
                self.JobHistoryContainer.isHidden = false
                self.JobHistoryContainer.alpha = 1
            }
            
        default:
            print("")
        }
    }
}
