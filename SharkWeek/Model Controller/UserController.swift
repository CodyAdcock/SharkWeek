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
    let addy: Address? = Address(line1: "", city: "", state: "", zipCode: "")
    //vars
    static let db = Firestore.firestore()
    let userRef = db.collection("users")
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    //C
    
    func SignUpUser(firstName: String, lastName: String, email: String, password: String, age: Int, address: Address, bio: String, skill: String, phoneNumber: String, profilePicture: UIImage, completion: @escaping (Bool) -> Void){
        
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
                    let newUser = User(firstName: firstName, lastName: lastName, email: email, age: age, address: address, bio: bio, skill: skill, phoneNumber: phoneNumber, pictureAsString: "\(url)", uuid: uuid)
                    
                    //set the current user as the newly created user
                    self.currentUser = newUser
                    
                    let testAddressCollection = self.userRef.document(uuid).collection("Address")
                    //upload a dictionary of the user to Firestore
                    let values = ["firstName" : newUser.firstName, "lastName" : newUser.lastName, "email" : newUser.email, "age" : newUser.age, "bio" : newUser.bio, "skill" : newUser.skill, "phoneNumber" : newUser.phoneNumber, "reviewCount" : newUser.reviewCount, "starCount" : newUser.starCount, "picture" : newUser.pictureAsString, "isMinor" : newUser.isMinor, "uuid": newUser.uuid, "jobsCreated" : newUser.jobsCreated, "jobsCreatedCompleted" : newUser.jobsCreated, "jobsApplied" : newUser.jobsApplied, "jobsInProgress" : newUser.jobsInProgress, "jobsHiredCompleted" : newUser.jobsHiredCompleted] as [String : Any]
                    self.userRef.document(uuid).setData(values)
                    
                    let city = address.city
                    let line1 = address.line1
                    let line2 = address.line2 ?? ""
                    let state = address.state
                    let zipCode = address.zipCode
                    
                    let addressValues = ["city" : city,
                                         "line1" : line1,
                                         "line2" : line2,
                                         "state" : state,
                                         "zipCode" : zipCode] as [String : Any]
                    testAddressCollection.document("Address").setData(addressValues)
                    completion(true) ; return
                })
                
                // with metaData you can get information on the data such as file size and file type; only using it here for the completion handler for downloading the URL of it.
                // still want to download the image in order to convert it into a string to set in the users values
                // Maybe for later, add an observer instead of doing the download within the completion block; looks more impressive but not v familiar
                // getData if you want users to have the data downloaded to their local device, and accessible offline.
                // easiest way to quickly download a file, but loads its entirety into memory; protect against memory issues using the required maxSize
            }
        }
    }
    
    //R
    
    func signInUser(email: String, password: String, completion: @escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                completion(false)
                print("🎃There was an error creating the user  🎃\(error.localizedDescription)")
                return
            } else {
                
                completion(true)
            }
        })
    }
    
    // TODO: - Fix this
    func grabUsersPicture(user: User, completion: @escaping (Bool) -> ()) {
        
        // this would be used to grab a image as url and download it,
//        userRef.document(user.uuid).getDocument { (querySnapshot, error) in
//            if let error = error {
//                print("Could not grab the users document data \(error.localizedDescription)")
//                return
//            }
//            guard let imageAsString = querySnapshot?.get("picture") as? String else { return }
        
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
        
        userRef.document(uid).collection("Address").document("Address").getDocument { (querySnapshot, error) in
            if let error = error {
                print("Whack failed address read \(error.localizedDescription)")
                return
            } else {
                guard let line1 = querySnapshot?.get("line1") as? String ,
                    let line2 = querySnapshot?.get("line2") as? String ,
                    let city = querySnapshot?.get("city") as? String ,
                    let state = querySnapshot?.get("state") as? String ,
                    let zipCode = querySnapshot?.get("zipCode") as? String  else { return }
                guard let addy = self.addy else { return }
                addy.city = city
                addy.line1 = line1
                addy.line2 = line2
                addy.state = state
                addy.zipCode = zipCode
            }
        }
        
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
            
            guard let address = self.addy else {return}
            
            let user = User(firstName: firstName, lastName: lastName, email: email, age: age, address: address, bio: bio, skill: skill, phoneNumber: phoneNumber, reviewCount: reviewCount, starCount: starCount,  pictureAsString: picture, jobsCreated: jobsCreated, jobsCreatedCompleted: jobsCreatedCompleted, jobsApplied: jobsApplied, jobsInProgress: jobsInProgress, jobsHiredCompleted: jobsHiredCompleted, uuid: uuid)
            
            self.currentUser = user
            
            completion(nil)
        }
    }
    
    //U
    
    func updateUser(firstName: String, lastName: String, email: String, password: String, age: Int, address: Address, bio: String, skill: String, phoneNumber: String, profilePicture: UIImage, completion: @escaping (Bool) -> Void){
        
        guard let uuid = currentUser?.uuid else {return}
        
        //Grab the Photo, change it into data
        guard let photoAsData = profilePicture.jpegData(compressionQuality: 0.3) else {return}
        
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
//            var size = metaData.size
            
            
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
                self.currentUser?.pictureAsString = "\(url)"
                
                guard let updatedUser = self.currentUser else {print("Error unwrapping user in updated"); return}
                //upload a dictionary of the user to Firestore
                let values = ["firstName" : updatedUser.firstName, "lastName" : updatedUser.lastName, "email" : updatedUser.email, "age" : updatedUser.age, "bio" : updatedUser.bio, "skill" : updatedUser.skill, "phoneNumber" : updatedUser.phoneNumber, "reviewCount" : updatedUser.reviewCount, "starCount" : updatedUser.starCount, "picture" : updatedUser.pictureAsString, "isMinor" : updatedUser.isMinor, "uuid": updatedUser.uuid, "jobsCreated" : updatedUser.jobsCreated, "jobsCreatedCompleted" : updatedUser.jobsCreated, "jobsApplied" : updatedUser.jobsApplied, "jobsInProgress" : updatedUser.jobsInProgress, "jobsHiredCompleted" : updatedUser.jobsHiredCompleted] as [String : Any]
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
}

