//
//  BlockedUsersTableViewCell.swift
//  SharkWeek
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class BlockedUsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usersPicture: UIImageView!
    @IBOutlet weak var usersName: UILabel!
    
    var blockedUserAsRef: String? {
        didSet {
            updateViews()
        }
    }
    func updateViews() {
        guard let blockedUserAsRef = blockedUserAsRef else { return }
        FirestoreClient.shared.fetchFromFirestore(uuid: blockedUserAsRef) { (user: User?) in
            guard let user = user else { return }
            UserController.shared.grabUsersPicture(user: user, completion: { (success) in
                if success == true {
                    self.usersPicture.image = user.pictureAsImage
                }
            })
            self.usersName.text = (user.firstName + user.lastName)
        }
    }
}
