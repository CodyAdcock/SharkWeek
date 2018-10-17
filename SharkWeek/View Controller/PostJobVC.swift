//
//  PostJobVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PostJobVC: UIViewController {
    
        @IBOutlet weak var jobTitleTF: UITextField!
        @IBOutlet weak var payTF: UITextField!
        @IBOutlet weak var addressOneTF: UITextField!
        @IBOutlet weak var addressTwoTF: UITextField!
        @IBOutlet weak var cityTF: UITextField!
        @IBOutlet weak var stateTF: UITextField!
        @IBOutlet weak var zipCodeTF: UITextField!
        @IBOutlet weak var descriptionTV: UITextView!
        @IBOutlet weak var toolsNeededTF: UITextField!
        @IBOutlet weak var toolsProvidedTF: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            descriptionTV.layer.borderWidth = 0.5
            descriptionTV.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
            descriptionTV.layer.cornerRadius = 5
        }
    
    @IBAction func postJobButton(_ sender: Any) {
        if notEmpty(){
//            guard let title = jobTitleTF.text,
//                let pay = payTF.text,
//                let address1 = addressOneTF.text,
//                let address2 = addressTwoTF.text,
//                let city = cityTF.text,
//                
//                
//            
//            JobController.shared.createNewJob(title: <#T##String#>, description: <#T##String#>, category: <#T##String#>, pay: <#T##Int#>, address: <#T##Address#>, toolsNeeded: <#T##String?#>, toolsProvided: <#T##String?#>)
        }
        
    }
    
    @IBAction func selectCategoryButton(_ sender: Any) {
            
            
    }
        
    func notEmpty() -> Bool{
        
        return !(jobTitleTF.text?.isEmpty)! && !(payTF.text?.isEmpty)! && !(addressOneTF.text?.isEmpty)! && !(cityTF.text?.isEmpty)! && !(stateTF.text?.isEmpty)! && !(zipCodeTF.text?.isEmpty)! && !(descriptionTV.text?.isEmpty)! && !(toolsNeededTF.text?.isEmpty)! && !(toolsProvidedTF.text?.isEmpty)!
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



