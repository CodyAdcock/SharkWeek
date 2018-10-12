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
    var currentUser: User?
    
    //vars
    static let db = Firestore.firestore()
    let userRef = db.collection("users")
    let storage = Storage.storage()
    
    //C
    func SignUpUser(firstName: String, lastName: String, email: String, password: String, age: Int, address: Address, bio: String, skill: String, phoneNumber: String, profilePicture: UIImage, completion: @escaping (Bool) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error{print("🌗There was an error creating the User \(error) \(error.localizedDescription)🌗")
                completion(false) ; return
                
            }
            guard let user = authResult?.user else { print("Error Unwrapping"); return }
            let uuid = user.uid
            
            //Grab the Photo, change it into data
            guard let photoAsData = profilePicture.jpegData(compressionQuality: 1.0) else {return}
            
            //create referencees to storage, with child nodes for organization/easier data retrieval
            let storageRef = self.storage.reference()
            let imagesRef = storageRef.child("ProfileImages")
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
                    let newUser = User(firstName: firstName, lastName: lastName, email: email, age: age, address: address, bio: bio, skill: skill, phoneNumber: phoneNumber, picture: "\(url)", uuid: uuid)
                    
                    //set the current user as the newly created user
                    self.currentUser = newUser

                    let testAddressCollection = self.userRef.document(uuid).collection("Address")
                    //upload a dictionary of the user to Firestore
                    let values = ["firstName" : newUser.firstName, "lastName" : newUser.lastName, "email" : newUser.email, "age" : newUser.age, "bio" : newUser.bio, "skill" : newUser.skill, "phoneNumber" : newUser.phoneNumber, "reviewCount" : newUser.reviewCount, "starCount" : newUser.starCount, "picture" : newUser.picture, "isMinor" : newUser.isMinor, "uuid": newUser.uuid, "jobsCreated" : newUser.jobsCreated, "jobsCreatedCompleted" : newUser.jobsCreated, "jobsApplied" : newUser.jobsApplied, "jobsInProgress" : newUser.jobsInProgress, "jobsHiredCompleted" : newUser.jobsHiredCompleted] as [String : Any]
                    self.userRef.document(uuid).setData(values)
                    
                    let city = address.city
                    let line1 = address.line1
                    let line2 = address.line2
                    let state = address.state
                    let zipCode = address.zipCode
                    
                    let addressValues = ["city" : city,
                                         "line1" : line1,
                                         "line2" : line2 ?? "",
                                         "state" : state,
                    "zipCode" : zipCode] as [String : Any]
                    testAddressCollection.document("Address").setData(addressValues)
                })
                completion(true) ; return
                
                // with metaData you can get information on the data such as file size and file type; only using it here for the completion handler for downloading the URL of it.
                // still want to download the image in order to convert it into a string to set in the users values
                // Maybe for later, add an observer instead of doing the download within the completion block; looks more impressive but not v familiar
                // getData if you want users to have the data downloaded to their local device, and accessible offline.
                // easiest way to quickly download a file, but loads its entirety into memory; protect against memory issues using the required maxSize
            }
            
        }
        
    }
    
    //R
    func signInUser(email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("🎃There was an error creating the user  🎃\(error.localizedDescription)")
                return
            }
            //read and create user here
            self.readUser(completion: { (error) in
                if let error = error{
                    print("🤬 There was an error in \(#function) ; \(error) ; \(error.localizedDescription) 🤬")
                    return
                }
            })
        }
        
    }
    func readUser(completion: @escaping (Error?) -> ()){
        
        guard let uid = Auth.auth().currentUser?.uid else { return}
        userRef.document(uid).getDocument { (querySnapshot, error) in
            if let error = error {
                completion(error)
                print("there was an error finding user documents \(error.localizedDescription)")
            }
            
            guard let uuid = querySnapshot?.get("uuid") as? String else {print("Error reading uuid"); return}
            guard let firstName = querySnapshot?.get("firstName") as? String else {print("Error reading first name"); return}
            guard let lastName = querySnapshot?.get("lastName") as? String else {print("Error reading last name"); return}
            guard let email = querySnapshot?.get("email") as? String else {print("Error reading email"); return}
            guard let age = querySnapshot?.get("age") as? Int else {print("Error reading age"); return}
            guard let address = querySnapshot?.get("address") as? Address else {print("Error reading address"); return}
            guard let bio = querySnapshot?.get("bio") as? String else {print("Error reading bio"); return}
            guard let skill = querySnapshot?.get("skill") as? String else {print("Error reading skill"); return}
            guard let phoneNumber = querySnapshot?.get("phoneNumber") as? String else {print("Error reading phone number"); return}
            guard let reviewCount = querySnapshot?.get("reviewCount") as? Int else {print("Error reading review count"); return}
            guard let starCount = querySnapshot?.get("starCount") as? Int else {print("Error reading star count"); return}
            guard let picture = querySnapshot?.get("picture") as? String else {print("Error reading picture"); return}
            guard let jobsCreated = querySnapshot?.get("jobsCreated") as? [String] else {print("Error reading jobs created"); return}
            guard let jobsCreatedCompleted = querySnapshot?.get("jobsCreatedCompleted") as? [String] else {print("Error reading jobs created completed"); return}
            guard let jobsApplied = querySnapshot?.get("jobsApplied") as? [String] else {print("Error reading jobs applied"); return}
            guard let jobsInProgress = querySnapshot?.get("jobsInProgress") as? [String] else {print("Error reading jobs in progress"); return}
            guard let jobsHiredCompleted = querySnapshot?.get("jobsHiredCompleted") as? [String] else {print("Error reading jobs hired completed"); return}
            
            let user = User(firstName: firstName, lastName: lastName, email: email, age: age, address: address, bio: bio, skill: skill, phoneNumber: phoneNumber, reviewCount: reviewCount, starCount: starCount,  picture: picture, jobsCreated: jobsCreated, jobsCreatedCompleted: jobsCreatedCompleted, jobsApplied: jobsApplied, jobsInProgress: jobsInProgress, jobsHiredCompleted: jobsHiredCompleted, uuid: uuid)
            
            self.currentUser = user
            
            completion(nil)
        }
    }
    
    //U
    
    func updateUser(firstName: String, lastName: String, email: String, password: String, age: Int, address: Address, bio: String, skill: String, phoneNumber: String, profilePicture: UIImage, completion: @escaping (Bool) -> Void){
        
        guard let uuid = currentUser?.uuid else {return}
        
        //Grab the Photo, change it into data
        guard let photoAsData = profilePicture.jpegData(compressionQuality: 1.0) else {return}
        
        //create referencees to storage, with child nodes for organization/easier data retrieval
        let storageRef = self.storage.reference()
        let imagesRef = storageRef.child("ProfileImages")
        let userImageRef = imagesRef.child(uuid)
        
        //Photo
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
                
                //update current user
                self.currentUser?.firstName = firstName
                self.currentUser?.lastName = lastName
                self.currentUser?.email = email
                self.currentUser?.age = age
                self.currentUser?.address = address
                self.currentUser?.bio = bio
                self.currentUser?.skill = skill
                self.currentUser?.phoneNumber = phoneNumber
                self.currentUser?.picture = "\(url)"
                
                guard let updatedUser = self.currentUser else {print("Error unwrapping user in updated"); return}
                //upload a dictionary of the user to Firestore
                let values = ["firstName" : updatedUser.firstName, "lastName" : updatedUser.lastName, "email" : updatedUser.email, "age" : updatedUser.age, "bio" : updatedUser.bio, "skill" : updatedUser.skill, "phoneNumber" : updatedUser.phoneNumber, "reviewCount" : updatedUser.reviewCount, "starCount" : updatedUser.starCount, "picture" : updatedUser.picture, "isMinor" : updatedUser.isMinor, "uuid": updatedUser.uuid, "jobsCreated" : updatedUser.jobsCreated, "jobsCreatedCompleted" : updatedUser.jobsCreated, "jobsApplied" : updatedUser.jobsApplied, "jobsInProgress" : updatedUser.jobsInProgress, "jobsHiredCompleted" : updatedUser.jobsHiredCompleted] as [String : Any]
                self.userRef.document(updatedUser.uuid).setData(values)
            })
            completion(true) ; return
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
    
    
}
