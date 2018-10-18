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
    
    var jobs1: [Job] = []
    var jobs2: [Job] = []
    var jobs3: [Job] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView1.dataSource = self
        homeCollectionView1.delegate = self
        homeCollectionView2.dataSource = self
        homeCollectionView2.delegate = self
        homeCollectionView3.dataSource = self
        homeCollectionView3.delegate = self
        
        createMockData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUser = UserController.shared.currentUser
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case homeCollectionView1:
            return jobs1.count
        case homeCollectionView2:
            return jobs2.count
        case homeCollectionView3:
            return jobs3.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case homeCollectionView1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = jobs1[indexPath.row]
            return cell ?? UICollectionViewCell()
        case homeCollectionView2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = jobs2[indexPath.row]
            return cell ?? UICollectionViewCell()
        case homeCollectionView3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? homeCollectionViewCell
            cell?.job = jobs3[indexPath.row]
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    func createMockData(){
        var job1 = Job(title: "Job 1", description: "It's the first one", pay: 11, toolsNeeded: "NA", toolsProvided: "NA", employerRef: "NA", line1: "NA", city: "NA", state: "NA", zipCode: "NA")
        var job2 = Job(title: "Job 2", description: "It's the second one", pay: 22, toolsNeeded: "NA", toolsProvided: "NA", employerRef: "NA", line1: "NA", city: "NA", state: "NA", zipCode: "NA")
        var job3 = Job(title: "Job 3", description: "It's the third one", pay: 33, toolsNeeded: "NA", toolsProvided: "NA", employerRef: "NA", line1: "NA", city: "NA", state: "NA", zipCode: "NA")
        var job4 = Job(title: "Job 4", description: "It's the fourth one", pay: 44, toolsNeeded: "NA", toolsProvided: "NA", employerRef: "NA", line1: "NA", city: "NA", state: "NA", zipCode: "NA")
        var job5 = Job(title: "Job 5", description: "It's the fifth one", pay: 55, toolsNeeded: "NA", toolsProvided: "NA", employerRef: "NA", line1: "NA", city: "NA", state: "NA", zipCode: "NA")
        
        jobs1 = [job1, job2, job3, job4, job5]
        jobs2 = [job5, job4, job3, job2, job1]
        jobs3 = [job3, job4, job1, job5, job2]
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
