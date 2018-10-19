//
//  ViewApplicantsVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class ViewApplicantsTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
   
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCellID", for: indexPath) as? ViewApplicantsCell else {return UITableViewCell()}
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "createProfile") as! ProfileTableViewController
        present(viewController, animated: true)
    }
    
}

extension ViewApplicantsTVC: ViewApplicantCellDelegate {
    func hireButtonTapped() {
        let alertController = UIAlertController(title: "Hiring", message: "Continue only if you have already contacted this seeker", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Hire", style: .default, handler: { (_) in
            let viewController = UIStoryboard(name: "MyJobs", bundle: nil).instantiateViewController(withIdentifier: "ViewPostingVC") as! ProfileTableViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }))
        
        let waitAction = UIAlertAction(title: "Wait", style: .cancel, handler: nil)
        alertController.addAction(waitAction)
    }
    
    
}