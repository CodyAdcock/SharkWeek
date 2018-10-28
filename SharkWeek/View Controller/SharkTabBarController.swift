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
            let myJobsNav = UIStoryboard(name: "MyJobs", bundle: .main).instantiateInitialViewController(),
        let searchNav = UIStoryboard(name: "Search", bundle: .main).instantiateInitialViewController() else {return}
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home Icon"), tag: 0)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "My Profile Icon"), tag: 1)
        postJobNav.tabBarItem = UITabBarItem(title: "Post Job", image: #imageLiteral(resourceName: "Post Job Icon"), tag: 2)
        myJobsNav.tabBarItem = UITabBarItem(title: "My Jobs", image: #imageLiteral(resourceName: "My Jobs Icon"), tag: 3)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search Icon"), tag: 4)
        
        self.viewControllers = [ homeNav, profileNav, postJobNav, myJobsNav, searchNav]
    }
}
