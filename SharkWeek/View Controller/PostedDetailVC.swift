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
    @IBOutlet weak var viewPostingContainer: UIView!
    @IBOutlet weak var editPostingContainer: UIView!
    @IBOutlet weak var applicantContainer: UIView!
    
    var selectedJob: Job?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentAttributes()
        viewPostingContainer.isHidden = false
        editPostingContainer.isHidden = true
        applicantContainer.isHidden = true
    }
    
    func segmentAttributes() {
        segmentedControlLabel.layer.cornerRadius = 5.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
       
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            viewPostingContainer.isHidden = false
            editPostingContainer.isHidden = true
            applicantContainer.isHidden = true
        case 1:
            viewPostingContainer.isHidden = true
            editPostingContainer.isHidden = false
            applicantContainer.isHidden = true
        case 2:
            viewPostingContainer.isHidden = true
            editPostingContainer.isHidden = true
            applicantContainer.isHidden = false
        default: break
        }
    }
}
