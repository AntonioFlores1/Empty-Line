//
//  UserCollection.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UsersCollectionKeys {
    static let CollectionKey = "users"
    static let UserIdKey = "userId"
    static let DisplayNameKey = "displayName"
    static let EmailKey = "email"
    static let PhotoURLKey = "photoURL"
    static let JoinedDateKey = "joinedDate"
    static let BalanceKey = "balance"
    static let BioKey = "bio"
    static let FirstNameKey = "firstName"
    static let LastNameKey = "lastName"
}

extension DBService {
    static public func createNDUser(user: CCUser, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(UsersCollectionKeys.CollectionKey)
            .document(user.userId)
            .setData([ UsersCollectionKeys.DisplayNameKey : user.displayName,
                       UsersCollectionKeys.EmailKey       : user.email,
                       UsersCollectionKeys.PhotoURLKey    : user.photoURL ?? "",
                       UsersCollectionKeys.JoinedDateKey  : user.joinedDate,
                       UsersCollectionKeys.BalanceKey     : user.balance,
                       UsersCollectionKeys.BioKey         : user.bio ?? "",
                       UsersCollectionKeys.FirstNameKey   : user.firstName ?? "",
                       UsersCollectionKeys.LastNameKey    : user.lastName ?? "",
                       UsersCollectionKeys.UserIdKey      : user.userId
            ]) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
    static public func fetchUser(userId: String, completion: @escaping (Error?, CCUser?) -> Void) {
        DBService.firestoreDB
            .collection(UsersCollectionKeys.CollectionKey)
            .whereField(UsersCollectionKeys.UserIdKey, isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                } else if let snapshot = snapshot?.documents.first {
                    let userProfileCreator = CCUser(dict: snapshot.data())
                    completion(nil, userProfileCreator)
                }
        }
    }
    
    static public func searchUser(completion: @escaping(Error?, [CCUser]?) -> Void) {
        DBService.firestoreDB.collection(UsersCollectionKeys.CollectionKey)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                }
                if let snapshot = snapshot {
                    var bloggersArray = [CCUser]()
                    for document in snapshot.documents {
                        let searchBlogger = CCUser.init(dict: document.data())
                        bloggersArray.append(searchBlogger)
                    }
                    completion(nil, bloggersArray)
                }
        }
    }
}
