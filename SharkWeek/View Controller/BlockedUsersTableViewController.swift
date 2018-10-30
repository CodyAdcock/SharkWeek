//
//  BlockedUsersTableViewController.swift
//  SharkWeek
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class BlockedUsersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserController.shared.currentUser?.blockedUsers.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = UserController.shared.currentUser
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "blockedUsersCell", for: indexPath) as? BlockedUsersTableViewCell else { return UITableViewCell() }
        cell.blockedUserAsRef = currentUser?.blockedUsers[indexPath.row]
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let currentUser = UserController.shared.currentUser else { return }
            currentUser.blockedUsers.remove(at: indexPath.row)
            UserController.shared.userRef.document(currentUser.uuid).updateData(["blockedUsers" : currentUser.blockedUsers])
            tableView.reloadData()
        }
    }
}

