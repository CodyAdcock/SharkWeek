//
//  FirestoreClient.swift
//  SharkWeek
//
//  Created by Sam on 10/18/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import Firebase

class FirestoreClient{
    
    
    static let shared = FirestoreClient()
    
    func fetchFromFirestore<T: FirestoreFetchable>(uuid: String, completion: @escaping (T?) -> Void){
        let collectionReference = T.collection
        
        collectionReference.document(uuid).getDocument { (docSnap, error) in
            if let error = error{
                print("There was an error in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let docSnap = docSnap, docSnap.exists, let objectDictionary = docSnap.data() else {completion(nil) ; return}
            
            let object = T(with: objectDictionary, id: docSnap.documentID)
            completion(object)
        }
    }
    
    func fetchAllInACollectionFromFirestore<T: FirestoreFetchable>(completion: @escaping ([T]?) -> ()){
        let collectionReference = T.collection
        collectionReference.getDocuments { (querySnap, error) in
            guard let documents = querySnap?.documents else {completion(nil) ; return }
            let dictionaries = documents.compactMap{ $0.data() }
            var returnValue: [T] = []
            for dictionary in dictionaries {
                guard let uuid = dictionary["uuid"] as? String,
                    let object = T(with: dictionary, id: uuid) else { completion(nil) ; return }
                returnValue.append(object)
            }
            completion(returnValue)
        }
    }
    
    func fetchFirestoreWithFieldAndCriteria<T: FirestoreFetchable>(for field: String, criteria: String, completion: @escaping ([T]?) -> ()) {
            let collectionReference = T.collection
            let filteredCollection = collectionReference.whereField(field, isEqualTo: criteria)
            filteredCollection.getDocuments { (querySnap, error) in
                if let error = error {
                    print("there was an error retrieving documents that were filtered: \(#function) \(error.localizedDescription)")
                }
                guard let documents = querySnap?.documents else { completion(nil) ; return }
                let dictionaries = documents.compactMap { $0.data() }
                var returnValue: [T] = []
                for dictionary in dictionaries {
                    guard let uuid = dictionary["uuid"] as? String, let object = T(with: dictionary, id: uuid) else { return }
                    returnValue.append(object)
                }
                completion(returnValue)
            }
        }
    
    //
    //    func fetchFirestoreObjectsWithCriteria<T: FirestoreFetchable>(where field: String, value: String, completion: @escaping ([T]?) -> ()) {
    //
    //        let collectionReference = T.collection
    //
    //        let query = collectionReference.whereField(field, isEqualTo: value)
    //
    //
    //        collectionReference.getDocuments { (querySnap, error) in
    //            if let error = error {
    //                print("couldnt get documents in \(#function) \(error.localizedDescription)")
    //            }
    //
    //            guard let querySnap = querySnap else { completion(nil) ; return }
    //            let documents = querySnap.documents
    //
    //            let dictionaries = documents.compactMap{ $0.data() }
    //            var returnValue: [T] = []
    //            for dictionary in dictionaries {
    //                let returnDictionary = dictionary.filter { $0.value as? String == criteria }
    //                guard let uuid = dictionary["uuid"] as? String, let object = T(with: returnDictionary, id: uuid) else { completion(nil) ; return }
    //                returnValue.append(object)
    //
    //                completion(returnValue)
    //            }
    //
    //        }
    //    }
    
    //    func fetchFirestoreJobs<T: FirestoreFetchable>(toFetch: String, completion: @escaping([T]?) -> ()) {
    //        let collectionRef = T.collection
    //    }
    
    
    func fetchFirestoreFromArray<T: FirestoreFetchable>(typeReference: [String], user: User, completion: @escaping([T]?) ->()) {
        var returnValue: [T] = []
        let collectionReference = T.collection
        collectionReference.document(user.uuid).getDocument { (querySnap, error) in
            if let error = error {
                print("Error getting the document for: \(user.uuid) with error: \(error.localizedDescription) in func: \(#function)")
            }
            guard let querySnap = querySnap else { completion(nil) ; return }
            let test = querySnap.get(typeReference)
            let object = test
            
        }
        completion(returnValue)
        
    }
}
