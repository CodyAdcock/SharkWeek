//
//  PhotoSelectViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import Photos

protocol PhotoSelectViewControllerDelegate: class{
    
    func photoSelected(_ photo: UIImage)
}

class PhotoSelectViewController: UIViewController {
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var delegate: PhotoSelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        selectPhotoButton.setTitle("Select a Photo", for: .normal)
        photoImageView.image = nil
    }
    
    @IBAction func selectPhotoButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined || PHPhotoLibrary.authorizationStatus() == .denied {
            PHPhotoLibrary.requestAuthorization { (auth) in
                let alertController = UIAlertController(title: "Requesting access to camera roll", message: "Jobbify needs access to camera roll to set profile picture", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        } else {
            
        }
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
//                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
//            }))
//        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}


extension PhotoSelectViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectPhotoButton.setTitle("", for: .normal)
            photoImageView.image = photo
            delegate?.photoSelected(photo)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
