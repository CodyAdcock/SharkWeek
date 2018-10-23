//
//  EditPostVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class EditPostVC: UIViewController {
    
    
    var pickerData: [String] = []
    var category: String?
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
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
        //updateViews()
        pickerView.delegate = self
        pickerData = ["Category:", "Outdoor", "Indoor"]
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        // no idea wtf this is TODO:
        if jobTitleTF.text!.isEmpty || jobTitleTF.text != "" && payTF.text!.isEmpty || payTF.text != "" && addressOneTF.text!.isEmpty || addressOneTF.text != "" &&
            addressTwoTF.text!.isEmpty || addressTwoTF.text != "" && cityTF.text!.isEmpty || cityTF.text != "" && stateTF.text!.isEmpty || stateTF.text != "" &&
            zipCodeTF.text!.isEmpty || zipCodeTF.text != "" && toolsNeededTF.text!.isEmpty || toolsNeededTF.text != "" && toolsProvidedTF.text!.isEmpty || toolsProvidedTF.text != "" && descriptionTV.text!.isEmpty || descriptionTV.text != ""
        {
            return
        } else {
            //    updateButtonLabel.isEnabled = true
        }
    }
}

extension EditPostVC: UIPickerViewDelegate, UIPickerViewDataSource {
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

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

































//    var jobPoster: Job?
//    func updateViews() {
//        guard let jobPoster = jobPoster else {return}
//        jobTitleTF.text = jobPoster.title
//        payTF.text = "\(jobPoster.pay)"
//        descriptionTV.text = jobPoster.description
//        toolsNeededTF.text = jobPoster.toolsNeeded
//        toolsProvidedTF.text = jobPoster.toolsProvided
//
//        addressOneTF.text = jobPoster.line1
//        addressTwoTF.text = jobPoster.line2
//        cityTF.text = jobPoster.city
//        stateTF.text = jobPoster.state
//        zipCodeTF.text = jobPoster.zipCode
//    }


