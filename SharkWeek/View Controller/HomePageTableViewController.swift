//
//  HomePageViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/18/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var homeCollectionView1: UICollectionView!
    @IBOutlet weak var homeCollectionView2: UICollectionView!
    @IBOutlet weak var homeCollectionView3: UICollectionView!
    
    var currentUser: User?
    
    var defaultJobs: [Job] = []
    var indoorJobs: [Job] = []
    var outdoorJobs: [Job] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView1.dataSource = self
        homeCollectionView1.delegate = self
        homeCollectionView2.dataSource = self
        homeCollectionView2.delegate = self
        homeCollectionView3.dataSource = self
        homeCollectionView3.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUser = UserController.shared.currentUser
        FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "category", criteria: "Category:", completion: { (jobs: [Job]?) in
            guard let jobbies = jobs else {return}
            self.defaultJobs = jobbies
            self.homeCollectionView3.reloadData()
        })
        FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "category", criteria: "Indoor", completion: { (jobs: [Job]?) in
            guard let jobbies = jobs else {return}
            self.indoorJobs = jobbies
            self.homeCollectionView2.reloadData()
        })
        FirestoreClient.shared.fetchFirestoreWithFieldAndCriteria(for: "category", criteria: "Outdoor", completion: { (jobs: [Job]?) in
            guard let jobbies = jobs else {return}
            self.outdoorJobs = jobbies
            self.homeCollectionView1.reloadData()
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case homeCollectionView3:
            return defaultJobs.count
        case homeCollectionView2:
            return indoorJobs.count
        case homeCollectionView1:
            return outdoorJobs.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case homeCollectionView3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = defaultJobs[indexPath.row] 
            return cell ?? UICollectionViewCell()
        case homeCollectionView2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = indoorJobs[indexPath.row]
            return cell ?? UICollectionViewCell()
        case homeCollectionView1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = outdoorJobs[indexPath.row]
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
