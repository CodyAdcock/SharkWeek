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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
