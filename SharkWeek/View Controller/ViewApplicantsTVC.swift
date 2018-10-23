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
    
    var appliedJob: Job?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let appliedJob = appliedJob else { return 0 }
        return appliedJob.applicantsRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "applicantsCell", for: indexPath) as? ViewApplicantsCell else {return UITableViewCell()}
        guard let appliedJob = appliedJob else { return UITableViewCell() }
        cell.personInfoAsString = appliedJob.applicantsRef[indexPath.row]

        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - REFACTOR BASED ON PASSING DATA
        let vc = PostedDetailVC()
        guard let appliedJob = vc.selectedJob else { return }
        self.appliedJob = appliedJob
        
    }
}

extension ViewApplicantsTVC: ViewApplicantCellDelegate {
    func hireButtonTapped() {
        let alertController = UIAlertController(title: "Hiring", message: "Continue only if you have already contacted this seeker", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Hire", style: .default, handler: { (_) in
            // TODO: - lul wtf is this
            let viewController = UIStoryboard(name: "MyJobs", bundle: nil).instantiateViewController(withIdentifier: "ViewPostingVC") as! ViewApplicantsTVC
            self.navigationController?.pushViewController(viewController, animated: true)
        }))
        
        let waitAction = UIAlertAction(title: "Wait", style: .cancel, handler: nil)
        alertController.addAction(waitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}
