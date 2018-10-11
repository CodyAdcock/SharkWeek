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
    
    
    var stageOfSignUp = 1
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PicAndLabelStack.isHidden = true
        //rounded images
        ProfPictureImageView.layer.masksToBounds = false
        ProfPictureImageView.clipsToBounds = true
        ProfPictureImageView.layer.cornerRadius = ProfPictureImageView.frame.height / 2
        ContainerView.layer.masksToBounds = false
        ContainerView.clipsToBounds = true
        ContainerView.layer.cornerRadius = ProfPictureImageView.frame.height / 2
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectVC"{
            guard let destinationVC = segue.destination as? PhotoSelectViewController else {return}
            destinationVC.delegate = self
        }
    }
    
    //
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        ProfPictureImageView.image = photo
        
        UIView.animate(withDuration: 3) {
            self.ContainerView.alpha = 0
            self.ContainerView.isHidden = true
            self.PicAndLabelStack.alpha = 0
            self.PicAndLabelStack.isHidden = false
            self.PicAndLabelStack.alpha = 1

        }
        
        
        
        
        
    }
}
extension SignUpViewController: PhotoSelectViewControllerDelegate{
    func photoSelected(_ photo: UIImage) {
        self.photo = photo
    }
    
}
