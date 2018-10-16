//
//  SharkTabBarController.swift
//  SharkWeek
//
//  Created by DevMountain on 10/15/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SharkTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let profileNav = UIStoryboard(name: "Profile", bundle: .main).instantiateInitialViewController(),
            let homeNav = UIStoryboard(name: "Home", bundle: .main).instantiateInitialViewController(),
            let postJobNav = UIStoryboard(name: "PostJob", bundle: .main).instantiateInitialViewController(),
            let myJobsNav = UIStoryboard(name: "MyJobs", bundle: .main).instantiateInitialViewController() else {return}
        
        profileNav.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        homeNav.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        postJobNav.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        myJobsNav.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 3)
        
        self.viewControllers = [profileNav, homeNav, postJobNav, myJobsNav]
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
