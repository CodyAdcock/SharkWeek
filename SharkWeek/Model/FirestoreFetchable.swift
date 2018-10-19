//
//  FirestoreFetchable.swift
//  SharkWeek
//
//  Created by Sam on 10/18/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import Firebase

protocol FirestoreFetchable {
    var uuid: String {get}
    static var CollectionName: String {get}
    init?(with dictionary: [String : Any], id: String)
}

extension FirestoreFetchable{
    
    static var collection: CollectionReference{
        return Firestore.firestore().collection(Self.CollectionName)
    }
    
}
