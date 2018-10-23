//
//  ViewPostingVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//
import MapKit
import UIKit

class ViewPostingVC: UIViewController {
    
    //job applied overview
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var toolsProvidedLabel: UILabel!
    @IBOutlet weak var toolsNeededLabel: UILabel!
    
    //job poster image name and rating
    @IBOutlet weak var jobPosterImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!

    @IBOutlet weak var starLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobPosterImage.layer.masksToBounds = false
        jobPosterImage.clipsToBounds = true
        jobPosterImage.layer.cornerRadius = jobPosterImage.frame.height / 2
        updatePage()
    }
    
    func updatePage() {
        guard let job = UserController.shared.currentJob else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: job.employerRef) { (user: User?) in
           
            guard let employer = user else {return}
            UserController.shared.grabUsersPicture(user: employer) { (success) in
                if success == true {
                    self.jobPosterImage.image = employer.pictureAsImage
                    print("sick, loaded picture")
                } else {
                    print("Could not set the value for the users image")
                }
            }
            
            self.jobPosterImage.image = employer.pictureAsImage
            self.firstNameLabel.text = "\(employer.firstName) \(employer.lastName)"
            
            if employer.reviewCount != 0{
                let rating = employer.starCount / employer.reviewCount
                switch rating {
                case 1:
                    self.starLabel.text = Stars.one
                case 2:
                    self.starLabel.text = Stars.two
                case 3:
                    self.starLabel.text = Stars.three
                case 4:
                    self.starLabel.text = Stars.four
                case 5:
                    self.starLabel.text = Stars.five
                default:
                    self.starLabel.text = Stars.zero
                }
            }else{
                self.starLabel.text = Stars.zero
            }
        }
        categoryLabel.text = job.category
        jobTitleLabel.text = job.title
        payLabel.text = "$\(job.pay)"
        descriptionLabel.text = job.description
        toolsProvidedLabel.text = job.toolsProvided
        toolsNeededLabel.text = job.toolsNeeded
    }
}
