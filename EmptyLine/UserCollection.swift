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
    static let userNameKey = "userName"
    static let EmailKey = "email"
    static let PhotoURLKey = "photoURL"
    static let FirstNameKey = "firstName"
    static let LastNameKey = "lastName"
    static let fullNameKey = "fullName"
    static let passwordKey = "password"
    static let cardNumberKey = "cardNumber"
    static let cardCVVKey = "cardCVV"
    static let expiringMonthKey = "expiringMonth"
    static let expiringDayKey = "expiringDay"
    static let expiringYearKey = "expiringYear"
    static let streetAddressKey = "streetAddress"
    static let cityNameKey = "cityName"
    static let stateNameKey = "stateName"
    static let zipCodeKey = "zipCode"
}

extension DBService {
    static public func createNDUser(user: CCUser, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(UsersCollectionKeys.CollectionKey)
            .document(user.userId)
            .setData([ UsersCollectionKeys.UserIdKey      : user.userId,
                       UsersCollectionKeys.userNameKey: user.userName,
                       UsersCollectionKeys.EmailKey       : user.email,
                       UsersCollectionKeys.PhotoURLKey    : user.photoURL ?? "",
                       UsersCollectionKeys.FirstNameKey   : user.firstName ?? "",
                       UsersCollectionKeys.LastNameKey    : user.lastName ?? "",
                       UsersCollectionKeys.fullNameKey: user.fullName,
                       UsersCollectionKeys.passwordKey: user.password,
                       UsersCollectionKeys.cardNumberKey: user.cardNumber,
                       UsersCollectionKeys.cardCVVKey: user.cardCVV,
                       UsersCollectionKeys.expiringMonthKey: user.expiringMonth,
                       UsersCollectionKeys.expiringDayKey: user.expiringDay,
                       UsersCollectionKeys.expiringYearKey: user.expiringYear,
                       UsersCollectionKeys.streetAddressKey: user.streetAddress,
                       UsersCollectionKeys.cityNameKey: user.cityName,
                       UsersCollectionKeys.stateNameKey: user.stateName,
                       UsersCollectionKeys.zipCodeKey: user.zipCode,
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
