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
    
    var detailArray: User?
    
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
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
