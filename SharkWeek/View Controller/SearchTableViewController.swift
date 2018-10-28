//
//  SearchTableViewController.swift
//  SharkWeek
//
//  Created by Sam on 10/22/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    var searchedJobs: [Job] = []
    var pickerData: [String] = []
    var category: String?
    let jobRef = JobController.shared.jobCollection
    let selectedUser = UserController.shared.selectedUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pickerView.delegate = self
        pickerData = ["Category:", "Outdoor", "Indoor"]
    }
    
    // MARK: - Table view data source    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedJobs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchJobsCellID", for: indexPath) as? SearchTableViewCell else { return UITableViewCell()}
        let job = searchedJobs[indexPath.row]
        cell.searchedJob = job
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserController.shared.currentJob = searchedJobs[indexPath.row]
        guard let employerRef = UserController.shared.currentJob?.employerRef else { return }
        FirestoreClient.shared.fetchFromFirestore(uuid: employerRef) { (user: User?) in
            guard let user = user else { return }
            guard let currentUser = UserController.shared.currentUser else { return }
            if user.blockedUsers.contains(currentUser.uuid) {
                let alertController = UIAlertController(title: "Person has blocked you!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier: "toAppliedVC", sender: self)
            }
        }
    }
}

extension SearchTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = pickerData[row]
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.view.endEditing(true)
        
        guard let text = searchBar.text, !text.isEmpty else { return }
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)
        
        if category != nil  {
            FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "category", criteria: self.category!) { (jobs: [Job]?) in
                guard let jobs = jobs else { return }
                self.searchedJobs = jobs
                
            }
            if decimalRange != nil {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "zipCode", criteria: text) { (jobs: [Job]?) in
                    guard let searchingByZip = jobs else { return }
                    self.searchedJobs = searchingByZip
                    self.searchedJobs.removeAll(where: { (job) -> Bool in
                        job.category != self.category
                    })
                    self.tableView.reloadData()
                }
                
            } else {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "city", criteria: text) { (jobs: [Job]?) in
                    guard let searchingJobsByCity = jobs else { return}
                    self.searchedJobs = searchingJobsByCity
                    self.searchedJobs.removeAll(where: { (job) -> Bool in
                        job.category != self.category
                    })
                    self.tableView.reloadData()
                }
            }
        }
        else if category == nil {
            if decimalRange != nil {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "zipCode", criteria: text) { (jobs: [Job]?) in
                    guard let jobs = jobs else { return }
                    self.searchedJobs = jobs
                    self.tableView.reloadData()
                }
            } else {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "city", criteria: text) { (jobs: [Job]?) in
                    guard let jobs = jobs else { return }
                    self.searchedJobs = jobs
                    self.tableView.reloadData()
                }
            }
        }
    }
}
