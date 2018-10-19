//
//  SignUpViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var BioAndSkillsTextView: UITextView!
    @IBOutlet weak var FirstNameAgeTextField: UITextField!
    @IBOutlet weak var LastNamePhoneTextField: UITextField!
    @IBOutlet weak var EmailAddressLine1TextField: UITextField!
    @IBOutlet weak var PasswordAddressLine2TextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var ZipTextField: UITextField!
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var ProfPictureImageView: UIImageView!
    @IBOutlet weak var WelcomeUserLabel: UILabel!
    @IBOutlet weak var PicAndLabelStack: UIStackView!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var StatusBarLabel: UILabel!
    @IBOutlet weak var CityStack: UIStackView!
    @IBOutlet weak var WelcomeTextStack: UIStackView!
    @IBOutlet weak var TextFieldsStack: UIStackView!
    @IBOutlet weak var TopTFStack: UIStackView!
    @IBOutlet weak var TextViewStack: UIStackView!
    @IBOutlet weak var bioSkillLabel: UILabel!
    @IBOutlet weak var FlavorWelcomeText: UILabel!
    
    
    var stageOfSignUp = 1
    
    
    let stageo: String = "○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○"
    let stage1: String = "●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○"
    let stage2: String = "●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○"
    let stage3: String = "●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯○"
    let stage4: String = "●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯●"
    
    //User set up local vars
    var firstName: String?
    var lastName: String?
    var email: String?
    var age: String?
    var line1: String?
    var line2: String?
    var city: String?
    var state: String?
    var zip: String?
    var bio: String?
    var skill: String?
    var phoneNumber: String?
    var photo: UIImage?
    var password: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        notFilledProperlyAlert.addAction(okAction)
        
        CityTextField.delegate = self
        StateTextField.delegate = self
        ZipTextField.delegate = self
        BioAndSkillsTextView.delegate = self
        FirstNameAgeTextField.delegate = self
        LastNamePhoneTextField.delegate = self
        EmailAddressLine1TextField.delegate = self
        PasswordAddressLine2TextField.delegate = self
        
        WelcomeTextStack.isHidden = true
        ProfPictureImageView.isHidden = true
        bioSkillLabel.text = ""
        
        //rounded images
        ProfPictureImageView.layer.masksToBounds = false
        ProfPictureImageView.clipsToBounds = true
        ProfPictureImageView.layer.cornerRadius = ProfPictureImageView.frame.height / 2
        ContainerView.layer.masksToBounds = false
        ContainerView.clipsToBounds = true
        ContainerView.layer.cornerRadius = ProfPictureImageView.frame.height / 2
        //hide city stack
        CityStack.isHidden = true
        TextViewStack.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectVC"{
            guard let destinationVC = segue.destination as? PhotoSelectViewController else {return}
            destinationVC.delegate = self
        }
    }
    
    //
    
    @objc func keyboardWillAppear(notification: Notification){
        guard let keyBoardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        view.frame.origin.y = (-keyBoardRect.height + 155)
    }
    @objc func keyboardWillDisappear(notification: Notification){
        view.frame.origin.y = 0
    }
    
    let notFilledProperlyAlert = UIAlertController(title: "Something seems to be missing", message: "Please make sure all fields are filled out!", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    
    func firstTransition(){
        
        //pull and check
        firstName = FirstNameAgeTextField.text
        lastName = LastNamePhoneTextField.text
        email = EmailAddressLine1TextField.text
        password = PasswordAddressLine2TextField.text
        ProfPictureImageView.image = photo
        
        if photo == nil || firstName == "" || lastName == "" || email == "" || password == ""{
            present(notFilledProperlyAlert, animated: true)
            return
        }
        
        //pic transition
        StatusBarLabel.text = stage2
        
        //swap pics
        ProfPictureImageView.isHidden = false
        ContainerView.isHidden = true
        
        //show welcome text
        UIView.animate(withDuration: 0.5, animations:{
            self.WelcomeTextStack.alpha = 0
            self.WelcomeTextStack.isHidden = false
            self.WelcomeTextStack.alpha = 1
            
        })
        
        //Add row
        UIView.animate(withDuration: 0.5, animations:{
            self.CityStack.isHidden = false
            
        })
        
        
        
        //TextField maintanence
        FirstNameAgeTextField.text = ""
        FirstNameAgeTextField.placeholder = "Age"
        
        LastNamePhoneTextField.text = ""
        LastNamePhoneTextField.placeholder = "Phone Number"
        
        EmailAddressLine1TextField.text = ""
        EmailAddressLine1TextField.placeholder = "Address Line 1"
        
        PasswordAddressLine2TextField.text = ""
        PasswordAddressLine2TextField.placeholder = "Address Line 2"
        
        self.stageOfSignUp += 1

    }
    
    func secondTransition(){
        
        self.age = self.FirstNameAgeTextField.text
        self.phoneNumber = self.LastNamePhoneTextField.text
        self.line1 = self.EmailAddressLine1TextField.text
        self.line2 = self.PasswordAddressLine2TextField.text
        self.city = self.CityTextField.text
        self.state = self.StateTextField.text
        self.zip = self.ZipTextField.text
        
        if age == nil || phoneNumber == "" || line1 == "" || city == "" || state == "" || zip == ""{
            present(notFilledProperlyAlert, animated: true)
            return
        }
        
        ContinueButton.isHidden = true
        UIView.animate(withDuration: 0.3) {
            
            
            self.CityStack.isHidden = true
            self.PasswordAddressLine2TextField.isHidden = true
            self.EmailAddressLine1TextField.isHidden = true
            self.TopTFStack.isHidden = true
            self.bioSkillLabel.text = "Bio"
            
        }
        UIView.animate(withDuration: 0.2) {
            self.TextViewStack.isHidden = false
            self.WelcomeUserLabel.text = "Keep Going!"
            self.FlavorWelcomeText.text = "Let others know a bit about you by filling out your bio"
            self.BioAndSkillsTextView.layer.borderWidth = 0.5
            self.BioAndSkillsTextView.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
            self.BioAndSkillsTextView.layer.cornerRadius = 5
            
        }
        
        self.stageOfSignUp += 1

    }
    func thirdTransition(){
        bio = self.BioAndSkillsTextView.text
        
        if bio == ""{
            present(notFilledProperlyAlert, animated: true)
            return
        }
        
        UIView.animate(withDuration: 0.2){
            self.bioSkillLabel.text = "Skills"
            self.BioAndSkillsTextView.text = ""
            self.WelcomeUserLabel.text = "Last Thing!"
            self.FlavorWelcomeText.text = "List the skills that will help you complete your jobs"
            
        }
        self.stageOfSignUp += 1

    }
    func fourthTransition(){
        
        if skill == ""{
            present(notFilledProperlyAlert, animated: true)
            return
        }
        
        skill = BioAndSkillsTextView.text
        guard let firstName = firstName,
            let lastName = lastName,
            let email = email,
            let ageAsString = age,
            let ageAsInt = Int(ageAsString),
            let line1 = line1,
            let city = city,
            let state = state,
            let zip = zip,
            let bio = bio,
            let skill = skill,
            let phoneNumber = phoneNumber,
            let picture = photo,
            let password = password else {return}
        
        UserController.shared.SignUpUser(firstName: firstName, lastName: lastName, email: email, password: password, age: ageAsInt, line1: line1, line2: line2, city: city, state: state, zipCode: zip, bio: bio, skill: skill, phoneNumber: phoneNumber, profilePicture: picture) { (success) in
            if success == true {
                self.navigationController?.popToRootViewController(animated: true)
                print("Sign up succccccccceded")
            } else if success == false {
                let alertController = UIAlertController(title: "Signup failed!", message: "There was an error singing up due to", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print("sign up failed")
            }
        }
        self.stageOfSignUp += 1

        
        
    }
    func fifthTransition(){
        self.navigationController?.popToRootViewController(animated: true)
        self.stageOfSignUp += 1

    }
    
    
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        
        
        switch self.stageOfSignUp{
        case 1:
            
            StatusBarLabel.text = self.stage2
            firstTransition()
        case 2:
            StatusBarLabel.text = self.stage3
            secondTransition()
            
        case 3:
            StatusBarLabel.text = self.stage4
            thirdTransition()
            
        case 4:
            fourthTransition()
            
        case 5:
            fifthTransition()
            
        default:
            return
        }
    }
    
    
}
extension SignUpViewController: PhotoSelectViewControllerDelegate{
    func photoSelected(_ photo: UIImage) {
        self.photo = photo
    }
    
}
