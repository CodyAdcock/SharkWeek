//
//  MyJobsTVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class MyJobsTVC: UITableViewController {
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    var sharedArray: [String] = []
    var currentUser: User?
    
//    var currentArray: [String] = []
//    var historyArray: [String] = []
//    var appliedArray: [String] = []
//    var postedArray: [String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = UserController.shared.currentUser
    }
    
    func updateViews(){
        guard let currentUser = currentUser else {return}
        
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            sharedArray = currentUser.jobsInProgress
        case 1:
            sharedArray = currentUser.jobsHiredCompleted
        case 2:
            sharedArray = currentUser.jobsApplied
        case 3:
            sharedArray = currentUser.jobsCreated
        default:
            sharedArray = []
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sharedArray.count
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCellID", for: indexPath) as? myJobsCell else {return UITableViewCell()}
        
//        let jobRef = sharedArray[indexPath.row]
//        cell.myJob = JobController.shared.readJob(jobRef)
        
        
        return cell// ?? UITableViewCell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "toDetailVc", sender: self)
        case 1:
            performSegue(withIdentifier: "toDetailVc", sender: self)
        case 2:
            performSegue(withIdentifier: "toDetailVc", sender: self)
        case 3:
            performSegue(withIdentifier: "toViewJobVC", sender: self)
        default:
            sharedArray = []
        }
        
        
//        if segue.identifier == "toDetailVc"{
//
//        }
//        if segue.identifier == "toViewJobVC"{
//
//        }
    }
    
    
}
