//
//  ViewJobVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PostedDetailVC: UIViewController {
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentAttributes()
    }
    
    func segmentAttributes() {
        segmentedControlLabel.layer.cornerRadius = 5.0
        segmentedControlLabel.backgroundColor = .lightGray
        segmentedControlLabel.tintColor = .darkGray
        segmentedControlLabel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let alertController = UIAlertController(title: "This is the end of the road!", message: "Sorry, this functionality isn't ready yet! Proceed at your own boredom!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Sounds Good!", style: .default))
        present(alertController, animated: true)
    }
       
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "segueToViewPosting", sender: self)
            loadViewIfNeeded()
        case 1:
            performSegue(withIdentifier: "segueToEditPost", sender: self)
            loadViewIfNeeded()
        case 2:
            performSegue(withIdentifier: "segueToViewApplicants", sender: self)
            loadViewIfNeeded()
        default: break
        }
    }
}
