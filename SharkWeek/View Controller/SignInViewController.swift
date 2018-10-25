//
//  SignInViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class SignInViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailAddressTextField.delegate = self
        PasswordTextField.delegate = self
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = EmailAddressTextField.text, !email.isEmpty,
            let password = PasswordTextField.text, !password.isEmpty else { return }
        UserController.shared.signInUser(email: email, password: password) { (success) in
            if success == true {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                UserController.shared.readUser(userID: uid, completion: { (error) in
                    if let error = error {
                        print("gang\(error.localizedDescription)")
                        return
                    }
                    print("signed in")
                    self.navigationController?.popToRootViewController(animated: true)
                })
            } else {
                let alertController = UIAlertController(title: "Error!", message: "Could not sign in", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelSignUpButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
