//
//  PersonalInfoViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class OtherPersonalInfoViewController: UIViewController {
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var SkillsLabel: UILabel!
    
    var selectedUser: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedUser = UserController.shared.selectedUser
        guard let selectedUser = selectedUser else {return}
        
        PhoneNumberLabel.text = "\(selectedUser.phoneNumber)"
        BioLabel.text = selectedUser.bio
        SkillsLabel.text = selectedUser.skill
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
