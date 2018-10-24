//
//  RatingViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/22/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    var rating: Int?
    
    @IBOutlet weak var whiteBackView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var firstStar: UIButton!
    @IBOutlet weak var secondStar: UIButton!
    @IBOutlet weak var thirdStar: UIButton!
    @IBOutlet weak var fourthStar: UIButton!
    @IBOutlet weak var fifthStar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
        descriptionTextView.layer.cornerRadius = 5
        
        whiteBackView.layer.borderWidth = 0.5
        whiteBackView.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
        whiteBackView.layer.cornerRadius = 5
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
        
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let flavorText = descriptionTextView.text else {return}
        if flavorText == "" {return}
        guard let rating = rating else {return}
        var isEmployer: Bool?
        guard let user = UserController.shared.currentUser else {return}
        guard let job = UserController.shared.currentJob else {return}
        if user.uuid == job.employerRef{
            isEmployer = true
            guard let isEmployer = isEmployer else {return}
            JobController.shared.rateJob(jobRef: job.uuid, starCount: rating, description: flavorText, employerRating: isEmployer)
            JobController.shared.completeJob(jobRef: job.uuid)
            self.dismiss(animated: true) {}
        }else if user.uuid == job.chosenOneRef{
            isEmployer = false
            guard let isEmployer = isEmployer else {return}
            JobController.shared.rateJob(jobRef: job.uuid, starCount: rating, description: flavorText, employerRating: isEmployer)
            JobController.shared.completeJob(jobRef: job.uuid)
            self.dismiss(animated: true) {}
        }else{
            print("There was an error reading the user during the review process")
        }
    }
    @IBAction func oneStarButtonTapped(_ sender: Any) {
        firstStar.setTitle("★", for: .normal)
        secondStar.setTitle("☆", for: .normal)
        thirdStar.setTitle("☆", for: .normal)
        fourthStar.setTitle("☆", for: .normal)
        fifthStar.setTitle("☆", for: .normal)
        rating = 1
    }
    @IBAction func twoStarButtonTapped(_ sender: Any) {
        firstStar.setTitle("★", for: .normal)
        secondStar.setTitle("★", for: .normal)
        thirdStar.setTitle("☆", for: .normal)
        fourthStar.setTitle("☆", for: .normal)
        fifthStar.setTitle("☆", for: .normal)
        rating = 2
    }
    @IBAction func threeStarButtonTapped(_ sender: Any) {
        firstStar.setTitle("★", for: .normal)
        secondStar.setTitle("★", for: .normal)
        thirdStar.setTitle("★", for: .normal)
        fourthStar.setTitle("☆", for: .normal)
        fifthStar.setTitle("☆", for: .normal)
        rating = 3
    }
    @IBAction func fourStarButtonTapped(_ sender: Any) {
        firstStar.setTitle("★", for: .normal)
        secondStar.setTitle("★", for: .normal)
        thirdStar.setTitle("★", for: .normal)
        fourthStar.setTitle("★", for: .normal)
        fifthStar.setTitle("☆", for: .normal)
        rating = 4
    }
    @IBAction func fiveStarButtonTapped(_ sender: Any) {
        firstStar.setTitle("★", for: .normal)
        secondStar.setTitle("★", for: .normal)
        thirdStar.setTitle("★", for: .normal)
        fourthStar.setTitle("★", for: .normal)
        fifthStar.setTitle("★", for: .normal)
        rating = 5
    }
    
}
