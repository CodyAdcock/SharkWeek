//
//  ViewJobVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PostedDetailVC: UIViewController {
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let alertController = UIAlertController(title: "This is the end of the road!", message: "Sorry, this functionality isn't ready yet! Proceed at your own boredom!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Sounds Good!", style: .default))
        present(alertController, animated: true)
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        
        
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
