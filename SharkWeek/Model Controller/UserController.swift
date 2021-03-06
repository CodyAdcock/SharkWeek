//
//  UserController.swift
//  SharkWeek
//
//  Created by Cody on 10/10/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage


class UserController{
    
    //Singleton
    static let shared = UserController()
    private init(){}
    
    //Source of Truth
    var currentUser: User?{
        didSet{
            print("Yo User Got Changed")
        }
    }
    var currentJob: Job?
    var selectedUser: User?
    //vars
    static let db = Firestore.firestore()
    let userRef = db.collection("users")
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    //C
    
    func SignUpUser(firstName: String, lastName: String, email: String, password: String, age: Int, line1: String, line2: String?, city: String, state: String, zipCode: String, bio: String, skill: String, phoneNumber: String, profilePicture: UIImage, completion: @escaping (Bool) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error{print("🌗There was an error creating the User \(error) \(error.localizedDescription)🌗")
                completion(false) ; return
                
            }
            guard let user = authResult?.user else { print("Error Unwrapping"); return }
            let uuid = user.uid
            
            //Grab the Photo, change it into data
            guard let photoAsData = profilePicture.jpegData(compressionQuality: 0.3) else {return}
            //create referencees to storage, with child nodes for organization/easier data retrieval
            let imagesRef = self.storageRef.child("ProfileImages")
            let userImageRef = imagesRef.child(uuid)
            
            // this puts data into the storage
            // could instead use .putFile, which essentially does the same thing but for larger objects; have not found a use case for it with limited research
            userImageRef.putData(photoAsData, metadata: nil) { (metaData, error) in
                if let error = error {
                    print("👽Could not download data from the profile image \(error.localizedDescription)👽")
                    completion(false) ; return
                }
                
                userImageRef.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print("there was an error getting the images url \(error.localizedDescription)")
                        completion(false) ; return
                    }
                    guard let url = url else { return }
                    
                    //create a user with the current stuff
                    let newUser = User(firstName: firstName, lastName: lastName, email: email, age: age, bio: bio, skill: skill, phoneNumber: phoneNumber, pictureAsString: "\(url)", uuid: uuid, line1: line1, line2: line2, city: city, state: state, zipCode: zipCode)
                    
                    //set the current user as the newly created user
                    self.currentUser = newUser
    
                    //upload a dictionary of the user to Firestore
                    let values = ["firstName" : newUser.firstName, "lastName" : newUser.lastName, "email" : newUser.email, "age" : newUser.age, "bio" : newUser.bio, "skill" : newUser.skill, "phoneNumber" : newUser.phoneNumber, "reviewCount" : newUser.reviewCount, "starCount" : newUser.starCount, "picture" : newUser.pictureAsString, "isMinor" : newUser.isMinor, "uuid": newUser.uuid, "jobsCreated" : newUser.jobsCreated, "jobsCreatedCompleted" : newUser.jobsCreated, "jobsApplied" : newUser.jobsApplied, "jobsInProgress" : newUser.jobsInProgress, "jobsHiredCompleted" : newUser.jobsHiredCompleted, "city" : newUser.city, "line1" : newUser.line1, "line2" :newUser.line2 ?? "", "state" : newUser.state, "zipCode" : newUser.zipCode, "blockedUsers" : newUser.blockedUsers] as [String : Any]
                    self.userRef.document(uuid).setData(values)
                    
                    completion(true) ; return
                })
            }
        }
    }
    
    //R
    
    func signInUser(email: String, password: String, completion: @escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                completion(false)
                print("🎃There was an error signing in the user  🎃\(error.localizedDescription)")
                return
            } else {
                
                completion(true)
            }
        })
    }
    
    // TODO: - Fix this
    func grabUsersPicture(user: User, completion: @escaping (Bool) -> ()) {
        
            let imagesRef = self.storageRef.child("ProfileImages")
            imagesRef.child(user.uuid).getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                if let error = error {
                    print("Could not find image for your own profilePic \(error.localizedDescription)")
                    completion(false)
                }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                user.pictureAsImage = image
                completion(true)
            })
    }
    
    func readUser(userID: String, completion: @escaping (Error?) -> ()){
        let uid = userID
        
        userRef.document(uid).getDocument { (querySnapshot, error) in
            if let error = error {
                print("There was an error reading document \(error.localizedDescription)")
                completion(error) ; return
            }
            guard let querySnapshot = querySnapshot,
                let dictionary = querySnapshot.data() else { return }
            
            let userID = querySnapshot.documentID
            
            let user = User(with: dictionary, id: userID)
            
            self.currentUser = user
            
            completion(nil)
        }
    }
    
    //D
    func deleteUser(){
        let alertController = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete your account? This cannot be reverted", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (_) in
            Auth.auth().currentUser?.delete(completion: { (error) in
                if let error = error {
                    print("There was an error deleting the user \(error.localizedDescription)")
                }
            })
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    // Might need more work
    func signOut(user: User) {
        do {
            try Auth.auth().signOut()
        } catch {
            let alertController = UIAlertController(title: "Error!", message: "There was an error signing out, error: \(error)", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAlert)
            print("there was an error signing out for the current user \(error.localizedDescription)")
        }
    }
    
    func blockUser(uuid: String) {
        guard let currentUser = UserController.shared.currentUser else { return }
            currentUser.blockedUsers.append(uuid)
            self.userRef.document(currentUser.uuid).updateData(["blockedUsers" : currentUser.blockedUsers])
        }
}
