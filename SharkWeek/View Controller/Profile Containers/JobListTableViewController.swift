//
//  JobListTableViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import Firebase

class JobListTableViewController: UITableViewController {
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
//        currentUser = UserController.shared.currentUser
=======
        currentUser = UserData.shared.john
>>>>>>> d7b51dd8e9a9221b52784f7b48f92b5b790c88de

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        guard let count = currentUser?.jobsHiredCompleted.count else {return 0}
//        return count
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkHistoryCell", for: indexPath) //as? JobHistoryTableViewCell

        //guard let jobRef = currentUser?.jobsHiredCompleted[indexPath.row] else {return UITableViewCell()}
//        let job = UserController.db.collection("jobs").document(jobRef)
//        cell?.job = job

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
