//
//  User.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct CCUser {
    let userId: String
    let displayName: String
    let email: String
    let photoURL: String?
    let joinedDate: String
    let balance: Double
    let bio    : String?
    let firstName : String?
    let lastName : String?
    
    public var fullName: String {
        return ((firstName ?? "") + " " + (lastName ?? "")).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    init(userId: String, displayName: String, email: String, photoURL: String?, joinedDate: String, balance: Double, bio: String?,firstName: String, lastName: String) {
        self.userId = userId
        self.displayName = displayName
        self.email = email
        self.photoURL = photoURL
        self.joinedDate = joinedDate
        self.balance = balance
        self.bio = bio
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(dict: [String: Any]) {
        self.userId = dict[UsersCollectionKeys.UserIdKey] as? String ?? ""
        self.displayName = dict[UsersCollectionKeys.DisplayNameKey] as? String ?? ""
        self.email = dict[UsersCollectionKeys.EmailKey] as? String ?? ""
        self.photoURL = dict[UsersCollectionKeys.PhotoURLKey] as? String ?? ""
        self.joinedDate = dict[UsersCollectionKeys.JoinedDateKey] as? String ?? ""
        self.balance = dict[UsersCollectionKeys.BalanceKey] as? Double ?? 0.0
        self.bio = dict[UsersCollectionKeys.BioKey] as? String ?? ""
        self.firstName = dict[UsersCollectionKeys.FirstNameKey] as? String ?? ""
        self.lastName = dict[UsersCollectionKeys.LastNameKey] as? String ?? ""
    }
}
