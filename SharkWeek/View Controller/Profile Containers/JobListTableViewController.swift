//
//  JobListTableViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import Firebase

class JobListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var profileJobsTableView: UITableView!
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileJobsTableView.dataSource = self
        profileJobsTableView.delegate = self
        currentUser = UserController.shared.currentUser

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUser = UserController.shared.currentUser
        profileJobsTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let count = currentUser?.jobsCreated.count else {return 0}
        return count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkHistoryCell", for: indexPath) as? JobHistoryTableViewCell

        guard let jobRef = currentUser?.jobsCreated[indexPath.row] else {return UITableViewCell()}
        let job = JobController.shared.readOneJob(with: jobRef)
        cell?.job = job

        return UITableViewCell()
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
