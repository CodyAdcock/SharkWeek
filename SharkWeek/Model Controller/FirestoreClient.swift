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
                    completion(nil) ; return
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
}
