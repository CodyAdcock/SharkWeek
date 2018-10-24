//
//  ViewApplicantsVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class ViewApplicantsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewApplicantCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentJob = UserController.shared.currentJob else {return 0}
        return currentJob.applicantsRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "applicantsCell", for: indexPath) as? ViewApplicantsCell else {return UITableViewCell()}
        guard let currentJob = UserController.shared.currentJob else { return UITableViewCell() }
        cell.delegate = self
        cell.userRef = currentJob.applicantsRef[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentJob = UserController.shared.currentJob else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: currentJob.applicantsRef[indexPath.row]) { (user: User?) in
            UserController.shared.selectedUser = user
            self.performSegue(withIdentifier: "toOtherProfile", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func hireButtonTapped(cell: ViewApplicantsCell) {
        let hireAlert = UIAlertController(title: "Are you sure?", message: "Make sure that you have contacted this person before accepting. Once accepted you can not hire anyone else for this job.", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) in
            guard let job = UserController.shared.currentJob else {return}
            guard let userRef = cell.userRef else {return}
            FirestoreClient.shared.fetchFromFirestore(uuid: userRef, completion: { (user: User?) in
                guard let user = user else {return}
                JobController.shared.accept(userFor: job, user: user)
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        hireAlert.addAction(acceptAction)
        hireAlert.addAction(cancelAction)
        
        self.present(hireAlert, animated: true)
    }
    
}

