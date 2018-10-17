//
//  textFieldExtendor.swift
//  SharkWeek
//
//  Created by Sam on 10/17/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//
import UIKit

extension UIViewController: UITextFieldDelegate, UITextViewDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
