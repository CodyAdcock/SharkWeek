//
//  ProfileTableViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import Firebase

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
    
    static let db = Firestore.firestore()
    let reportRef = db.collection("reportedUsers")
    
    
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
        
        let alertController = UIAlertController(title: "Report abuse or Block User", message: "Report a user for misconduct with a message, or block them from seeing your posts/profile", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let blockAction = UIAlertAction(title: "Block", style: .cancel) { (_) in
            let blockAlertController = UIAlertController(title: "Are you sure?", message: "This will disable a user from seeing any of your jobs, and your profile", preferredStyle: .alert)
            let blockButton = UIAlertAction(title: "Block user", style: .default, handler: { (_) in
                guard let selectedUser = UserController.shared.selectedUser else { return }
                UserController.shared.blockUser(uuid: selectedUser.uuid)
            })
            let cancelActionForBlockAC = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            blockAlertController.addAction(blockButton)
            blockAlertController.addAction(cancelActionForBlockAC)
            self.present(blockAlertController, animated: true, completion: nil)
        }
        
        let reportAction = UIAlertAction(title: "Report", style: .default) { (report) in
            let reportAlertController = UIAlertController(title: "Report abuse", message: "Let us know what happened between you and the user and we'll look into it", preferredStyle: .alert)
            reportAlertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "type something..."
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let reportButton = UIAlertAction(title: "Submit report", style: .cancel, handler: { (report) in
                guard let text = reportAlertController.textFields?.first?.text else { return }
                guard let selectedUser = UserController.shared.selectedUser else { return }
                self.reportRef.document(selectedUser.uuid).getDocument(completion: { (querySnap, error) in
    
                    if let error = error {
                        print("could not get data back for user \(error.localizedDescription)")
                        return
                    }
                    guard let querySnap = querySnap else { return }
                    if querySnap.exists {
                    guard let reportsDictionary = querySnap.data() else { return }
                    guard var reasons = reportsDictionary["reasons"] as? [String] else { return }
                    reasons.append(text)
                    self.reportRef.document(selectedUser.uuid).updateData(["reasons" : reasons])
                    } else {
                        var reasons: [String] = []
                        reasons.append(text)
                        self.reportRef.document(selectedUser.uuid).setData(["reasons" : reasons])
                    }
                })
            })
            reportAlertController.addAction(cancelButton)
            reportAlertController.addAction(reportButton)
            self.present(reportAlertController, animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(reportAction)
        alertController.addAction(blockAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
