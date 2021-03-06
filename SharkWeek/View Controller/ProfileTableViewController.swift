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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ProfilePictureImageView.layer.masksToBounds = false
        self.ProfilePictureImageView.clipsToBounds = true
        self.ProfilePictureImageView.layer.cornerRadius = ProfilePictureImageView.frame.height / 2
        
        if UserController.shared.currentUser == nil{
            let signInAlertController = UIAlertController(title: "Please Sign in to view this content!", message: "A lot of our app isn't very useful if you aren't signed in! Please sign in!", preferredStyle: .alert)
            let signInAction = UIAlertAction(title: "Go There Now!", style: .default) { (action) in
                self.performSegue(withIdentifier: "toSignInVC", sender: self)
            }
            let notNowAction = UIAlertAction(title: "Not Now", style: .cancel)
            signInAlertController.addAction(signInAction)
            signInAlertController.addAction(notNowAction)
            
            self.present(signInAlertController, animated: true, completion: nil)
        } else {
            
            guard let user = UserController.shared.currentUser else {return}
            
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
            
            ProfilePictureImageView.image = UserController.shared.currentUser?.pictureAsImage
            NameAgeLabel.text = fullName
            CityStateLabel.text = addressString
            
            switch user.reviewCount {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PersonalInfoContainer.isHidden = false
        self.PersonalInfoContainer.alpha = 1
        self.JobHistoryContainer.isHidden = true
        self.JobHistoryContainer.alpha = 0
        
        guard let currentUser = UserController.shared.currentUser else { return }
        
        self.ProfilePictureImageView.image = currentUser.pictureAsImage
        NameAgeLabel.text = "\(currentUser.firstName) \(currentUser.lastName), \(currentUser.age)"
        CityStateLabel.text = "\(currentUser.city), \(currentUser.state)"
        var rating = 0
        if currentUser.reviewCount != 0{
        rating = currentUser.starCount / currentUser.reviewCount
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
