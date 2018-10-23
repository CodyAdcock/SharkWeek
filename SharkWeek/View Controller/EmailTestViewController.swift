//
//  EmailTestViewController.swift
//  SharkWeek
//
//  Created by Sam on 10/23/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import MessageUI

class EmailTestViewController: UIViewController, MFMailComposeViewControllerDelegate {
    let reportEmails: [String] = ["samwayne11@gmail.com", "codyadcock10@gmail.com", "abdikadirpro@gmail.com"]
    let testSubject: String = "testing"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func test() {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.mailComposeDelegate = self
            controller.setCcRecipients(reportEmails)
            controller.setSubject(testSubject)
            controller.setMessageBody("testing sending report emails", isHTML: false)
        }
    }
}
