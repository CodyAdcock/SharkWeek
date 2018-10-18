//
//  PostJobVC.swift
//  SharkWeek
//
//  Created by Abdikadir Abdalla on 10/16/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PostJobVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
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
    
    var pickerData: [String] = []
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        pickerData = ["Category:", "Outdoor", "Indoor"]
        
        descriptionTV.layer.borderWidth = 0.5
        descriptionTV.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
        descriptionTV.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserController.shared.currentUser == nil{
            let signInAlertController = UIAlertController(title: "Please Sign in to view this content!", message: "A lot of our app isn't very useful if you aren't signed in! Please sign in! Visit the profile tab to sign in or sign up!", preferredStyle: .alert)
            let signInAction = UIAlertAction(title: "Go There Now!", style: .default) { (action) in
                self.performSegue(withIdentifier: "toSignInVC", sender: self)
            }
            let notNowAction = UIAlertAction(title: "Not Now", style: .cancel)
            signInAlertController.addAction(signInAction)
            signInAlertController.addAction(notNowAction)
            
            self.present(signInAlertController, animated: true, completion: nil)
        }
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
    
    @IBAction func postJobButton(_ sender: Any) {
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
                let toolsProvided = toolsProvidedTF.text else {return}
            
            JobController.shared.createNewJob(title: title, description: description, category: "Default", pay: pay, toolsNeeded: toolsNeeded, toolsProvided: toolsProvided, line1: address1, line2: address2, city: city, state: state, zipCode: zip)
            
            let alert = UIAlertController(title: "Job Created!", message: "supposedly...", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okayAction)
            present(alert, animated: true)
        }
        
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



