//
//  JobSearchScrollView.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//
import MapKit
import UIKit

class AppliedDetailVC: UIViewController {
    
    //job applied overview
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var toolsProvidedLabel: UILabel!
    @IBOutlet weak var toolsNeededLabel: UILabel!
    
    //job poster image name and rating
    @IBOutlet weak var jobPosterImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var starOneLabel: UILabel!
    @IBOutlet weak var starTwoLabel: UILabel!
    @IBOutlet weak var starThreeLabel: UILabel!
    @IBOutlet weak var starFourLabel: UILabel!
    @IBOutlet weak var starFiveLabel: UILabel!
    
    //map
    @IBOutlet weak var mapLabel: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updatePerson()
    }
    
    
    func updatePerson() {
        firstNameLabel.text = UserController.shared.currentUser?.firstName
        lastNameLabel.text = UserController.shared.currentUser?.lastName
        jobPosterImage.image = UserController.shared.currentUser?.pictureAsImage
        
        starOneLabel.text = Stars.one
        starTwoLabel.text = Stars.two
        starThreeLabel.text = Stars.three
        starFourLabel.text = Stars.four
        starFiveLabel.text = Stars.five
    }
    
    var appliedJob: Job?
    
    func updateViews() {
        guard let appliedJob = appliedJob else {return}
        categoryLabel.text = appliedJob.category
        jobTitleLabel.text = appliedJob.title
        payLabel.text = "\(appliedJob.pay)"
        descriptionTV.text = appliedJob.description
        toolsProvidedLabel.text = appliedJob.toolsProvided
        toolsNeededLabel.text = appliedJob.toolsProvided
    }
    
}

