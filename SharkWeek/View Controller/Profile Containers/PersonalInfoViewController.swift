//
//  PersonalInfoViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var SkillsLabel: UILabel!
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = UserController.shared.currentUser
        guard let currentUser = currentUser else {return}
        
        PhoneNumberLabel.text = "\(currentUser.phoneNumber)"
        BioLabel.text = currentUser.bio
        SkillsLabel.text = currentUser.skill
        
    }
    
}
