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
        let logo = #imageLiteral(resourceName: "JobbiesLogo")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UserController.shared.currentUser == nil { return }
        switch collectionView{
        case homeCollectionView3:
            UserController.shared.currentJob = defaultJobs[indexPath.row]
            guard let employerRef = UserController.shared.currentJob?.employerRef else { return }
            FirestoreClient.shared.fetchFromFirestore(uuid: employerRef) { (user: User?) in
                guard let user = user else { return }
                guard let currentUser = self.currentUser else { return }
                if user.blockedUsers.contains(currentUser.uuid) {
                    let alertController = UIAlertController(title: "Person has blocked you!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            guard let currentUser = self.currentUser else { return }
            if currentUser.blockedUsers.contains(employerRef) {
                let alertController = UIAlertController(title: "You have blocked this user!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier: "toAppliedVC", sender: self)
            }
            
        case homeCollectionView2:
            UserController.shared.currentJob = indoorJobs[indexPath.row]
            guard let employerRef = UserController.shared.currentJob?.employerRef else { return }
            FirestoreClient.shared.fetchFromFirestore(uuid: employerRef) { (user: User?) in
                guard let user = user else { return }
                guard let currentUser = self.currentUser else { return }
                if user.blockedUsers.contains(currentUser.uuid) {
                    let alertController = UIAlertController(title: "Person has blocked you!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            guard let currentUser = self.currentUser else { return }
            if currentUser.blockedUsers.contains(employerRef) {
                let alertController = UIAlertController(title: "You have blocked this user!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier: "toAppliedVC", sender: self)
            }
            
        case homeCollectionView1:
            UserController.shared.currentJob = outdoorJobs[indexPath.row]
            guard let employerRef = UserController.shared.currentJob?.employerRef else { return }
            FirestoreClient.shared.fetchFromFirestore(uuid: employerRef) { (user: User?) in
                guard let user = user else { return }
                guard let currentUser = self.currentUser else { return }
                if user.blockedUsers.contains(currentUser.uuid) {
                    let alertController = UIAlertController(title: "Person has blocked you!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            guard let currentUser = self.currentUser else { return }
            if currentUser.blockedUsers.contains(employerRef) {
                let alertController = UIAlertController(title: "You have blocked this user!", message: "You are not allowed to see their profile or postings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier: "toAppliedVC", sender: self)
            }
        default:
            print("That's not supposed to happen...")
            
        }
    }
}
