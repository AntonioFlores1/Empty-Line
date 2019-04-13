//
//  DBService.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

final class DBService {
    private init() {}
    
    public static var firestoreDB: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        return db
    }()
    
    static public var generateDocumentId: String {
        return firestoreDB.collection(UsersCollectionKeys.CollectionKey).document().documentID
    }
    static public func getProducts(productBarcode: String, completion: @escaping(Error?, Item?) -> Void){
        DBService.firestoreDB.collection(ItemCollectionKeys.CollectionKey).whereField(ItemCollectionKeys.BarcodeKey, isEqualTo: productBarcode).getDocuments { (snapShot, error) in
            if let error = error {
                completion(error, nil)
            } else {
                if let snapShot = snapShot?.documents.first {
                    let item = Item(dict: snapShot.data())
                    completion(nil, item)
                }
            }
        }
    }
}

