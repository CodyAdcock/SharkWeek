//
//  EditPostVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class EditPostVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var job: Job?
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
        
        descriptionTV.layer.borderWidth = 0.5
        descriptionTV.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
        descriptionTV.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let job = UserController.shared.currentJob else {return}
        jobTitleTF.text = job.title
        payTF.text = "\(job.pay)"
        addressOneTF.text = job.line1
        addressTwoTF.text = job.line2
        cityTF.text = job.city
        stateTF.text = job.state
        zipCodeTF.text = job.zipCode
        descriptionTV.text = job.description
        toolsNeededTF.text = job.toolsNeeded
        toolsProvidedTF.text = job.toolsProvided
        switch category {
        case "Outdoor":
            pickerView.selectedRow(inComponent: 1)
        case "Indoor":
            pickerView.selectedRow(inComponent: 2)
        default:
            pickerView.selectedRow(inComponent: 0)
        }
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @objc func keyboardWillAppear(notification: Notification){
        if jobTitleTF.text != "" && payTF.text != "" && addressOneTF.text != "" && addressTwoTF.text != "" && cityTF.text != "" && stateTF.text != "" && zipCodeTF.text != ""{
            guard let keyBoardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
            self.view.frame.origin.y = (-keyBoardRect.height)
        }
    }
    @objc func keyboardWillDisappear(notification: Notification){
        view.frame.origin.y = 0
    }
    
    func setDelegates() {
        jobTitleTF.delegate = self
        payTF.delegate = self
        addressOneTF.delegate = self
        addressTwoTF.delegate = self
        cityTF.delegate = self
        stateTF.delegate = self
        zipCodeTF.delegate = self
        descriptionTV.delegate = self
        toolsNeededTF.delegate = self
        toolsProvidedTF.delegate = self
    }
    
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
    
    
    
    @IBAction func updateButton(_ sender: Any) {
        // no idea wtf this is TODO:
        if notEmpty(){
            guard let title = jobTitleTF.text,
                let payAsString = payTF.text,
                let pay = Int(payAsString),
                let address1 = addressOneTF.text,
                let address2 = addressTwoTF.text,
                let city = cityTF.text,
                let state = stateTF.text,
                let zip = zipCodeTF.text,
                let description = descriptionTV.text,
                let toolsNeeded = toolsNeededTF.text,
                let toolsProvided = toolsProvidedTF.text,
                let category = category else { return }
            guard let job = UserController.shared.currentJob else {return}
            JobController.shared.updateJob(job: job, title: title, description: description, category: category, pay: pay, toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, line1: address1, line2: address2, city: city, state: state, zipCode: zip)
            guard let uuid = UserController.shared.currentJob?.uuid else {return}
            JobController.shared.readOneJob(with: uuid) { (job) in
                UserController.shared.currentJob = job
            }
            let alert = UIAlertController(title: "Job Updated!", message: "Check it out in the 'My Jobs' tab under 'Posted'", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okayAction)
            present(alert, animated: true)
        }
    }
    
    func notEmpty() -> Bool{
    
    return !(jobTitleTF.text?.isEmpty)! && !(payTF.text?.isEmpty)! && !(addressOneTF.text?.isEmpty)! && !(cityTF.text?.isEmpty)! && !(stateTF.text?.isEmpty)! && !(zipCodeTF.text?.isEmpty)! && !(descriptionTV.text?.isEmpty)! && !(toolsNeededTF.text?.isEmpty)! && !(toolsProvidedTF.text?.isEmpty)! && category != "Category:"
    }
    
}

