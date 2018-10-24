//
//  ViewApplicantsVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class ViewApplicantsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentJob = UserController.shared.currentJob else {return 0}
        return currentJob.applicantsRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "applicantsCell", for: indexPath) as? ViewApplicantsCell else {return UITableViewCell()}
        guard let currentJob = UserController.shared.currentJob else { return UITableViewCell() }
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
    
}

