//
//  ProfileTableViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class OtherProfileTableViewController: UITableViewController {
    
    //IBOutlets Main Page
    
    
    @IBOutlet weak var ProfilePictureImageView: UIImageView!
    @IBOutlet weak var NameAgeLabel: UILabel!
    @IBOutlet weak var CityStateLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var profileSegementedController: UISegmentedControl!
    
    //Container IBOutlets
    @IBOutlet weak var PersonalInfoContainer: UIView! //toPersonalInfoVC
    @IBOutlet weak var JobHistoryContainer: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ProfilePictureImageView.layer.masksToBounds = false
        self.ProfilePictureImageView.clipsToBounds = true
        self.ProfilePictureImageView.layer.cornerRadius = ProfilePictureImageView.frame.height / 2
        
        guard let user = UserController.shared.selectedUser else {return}
        
        UserController.shared.grabUsersPicture(user: user) { (success) in
            if success == true {
                self.ProfilePictureImageView.image = user.pictureAsImage
                print("sick, loaded picture")
            } else {
                print("Could not set the value for the users image")
            }
        }
        
        let addressString = "\(user.city), \(user.state)"
        let fullName = "\(user.firstName) \(user.lastName)"
        
        ProfilePictureImageView.image = UserController.shared.selectedUser?.pictureAsImage
        NameAgeLabel.text = fullName
        CityStateLabel.text = addressString
        
        if user.reviewCount == 0{
            RatingLabel.text = Stars.zero
            return
        }
        let rating = user.starCount / user.reviewCount
        
        switch rating {
        case 0:
            RatingLabel.text = Stars.zero
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
            RatingLabel.text = Stars.zero
            
        }
    }
    @IBAction func settingsButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PersonalInfoContainer.isHidden = false
        self.PersonalInfoContainer.alpha = 1
        self.JobHistoryContainer.isHidden = true
        self.JobHistoryContainer.alpha = 0
        
        guard let selectedUser = UserController.shared.selectedUser else { return }
        
        self.ProfilePictureImageView.image = selectedUser.pictureAsImage
        NameAgeLabel.text = "\(selectedUser.firstName) \(selectedUser.lastName), \(selectedUser.age)"
        CityStateLabel.text = "\(selectedUser.city), \(selectedUser.state)"
        var rating = 0
        if selectedUser.reviewCount != 0{
            rating = selectedUser.starCount / selectedUser.reviewCount
        }
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
