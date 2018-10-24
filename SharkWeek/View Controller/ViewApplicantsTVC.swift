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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//extension ViewApplicantsTVC: ViewApplicantCellDelegate {
//    func hireButtonTapped() {
//        let alertController = UIAlertController(title: "Hiring", message: "Continue only if you have already contacted this seeker", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Hire", style: .default, handler: { (_) in
//            // TODO: - lul wtf is this
//            let viewController = UIStoryboard(name: "MyJobs", bundle: nil).instantiateViewController(withIdentifier: "ViewPostingVC") as! ViewApplicantsTVC
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }))
//        
//        let waitAction = UIAlertAction(title: "Wait", style: .cancel, handler: nil)
//        alertController.addAction(waitAction)
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    
//}
