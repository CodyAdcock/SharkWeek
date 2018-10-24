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
    @IBOutlet weak var applyButton: UIButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if doesNotExistsForUser(){
            applyButton.isEnabled = true
            applyButton.tintColor = .white
            applyButton.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.7647058824, blue: 0.568627451, alpha: 1)
            
        }else{
            applyButton.isEnabled = false
            applyButton.tintColor = .white
            applyButton.backgroundColor = nil

        }
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
    
    
    @IBAction func userButtonTapped(_ sender: Any) {
         guard let job = UserController.shared.currentJob else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: job.employerRef) { (user: User?) in
            UserController.shared.selectedUser = user
            self.performSegue(withIdentifier: "toOtherProfile", sender: self)
        }
    }
    @IBAction func applyButtonTapped(_ sender: Any) {
        guard let job = UserController.shared.currentJob else {return}
        JobController.shared.applyToJob(job: job)
        let appliedAlert = UIAlertController(title: "Applied!", message: "You've been added to the list of applicants for this job. If you want to keep tabs on it, look in My Jobs. It may take a few minutes!", preferredStyle: .alert)
        appliedAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(appliedAlert, animated: true)
        applyButton.setTitle("Applied", for: .normal)
        applyButton.isEnabled = false
        applyButton.tintColor = .white
        applyButton.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.7647058824, blue: 0.568627451, alpha: 1)
    }
    
    
    func doesNotExistsForUser() -> Bool {
        guard let job = UserController.shared.currentJob else {return false}
        guard let user = UserController.shared.currentUser else {return false}
        let uid = job.uuid
        for jobRef in user.jobsApplied{
            if jobRef == uid{
                return false
            }
        }
        for jobRef in user.jobsCreated{
            if jobRef == uid{
                return false
            }
        }
        for jobRef in user.jobsInProgress{
            if jobRef == uid{
                return false
            }
        }
        for jobRef in user.jobsHiredCompleted{
            if jobRef == uid{
                return false
            }
        }
        for jobRef in user.jobsCreatedCompleted{
            if jobRef == uid{
                return false
            }
        }
        return true
    }
    
}
