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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pickerView.delegate = self
        pickerData = ["Category:", "Outdoor", "Indoor"]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension SearchTableViewController: UIPickerViewDelegate {
    
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
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        if category != nil  {
            FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "category", criteria: self.category!) { (jobs: [Job]?) in
                guard let jobs = jobs else { return }
                self.searchedJobs = jobs
                
            }
            if text.contains("0...9") {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "zipCode", criteria: text) { (jobs: [Job]?) in
                    JobController.shared.jobCollection.whereField("category", isEqualTo: self.category!)
                    guard let searchingJobsByZip = jobs else { return }
                    self.searchedJobs = searchingJobsByZip
                }
                
            } else {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "city", criteria: text) { (jobs: [Job]?) in
                    JobController.shared.jobCollection.whereField("category", isEqualTo: self.category!)
                    guard let searchingJobsByCity = jobs else { return}
                    self.searchedJobs = searchingJobsByCity
                }
            }
        }
        else if category == nil {
            if text.contains("0...9") {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "zipCode", criteria: text) { (jobs: [Job]?) in
                    guard let jobs = jobs else { return }
                    self.searchedJobs = jobs
                }
            } else {
                FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "city", criteria: text) { (jobs: [Job]?) in
                    guard let jobs = jobs else { return }
                    self.searchedJobs = jobs
                }
            }
        }
    }
}
