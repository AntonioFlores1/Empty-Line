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
    let userName: String
    let email: String
    let photoURL: String?
    let firstName : String?
    let lastName : String?
    
    public var fullName: String {
        return ((firstName ?? "") + " " + (lastName ?? "")).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    let password: String
    let cardNumber: String
    let cardCVV: String
    let expiringMonth: String
    let expiringDay: String
    let expiringYear: String
    let streetAddress: String
    let cityName: String
    let stateName: String
    let zipCode: String
    
    
    init(userId: String,userName: String, email: String, photoURL: String?,firstName: String?, lastName: String?, password: String, cardNumber: String, cardCVV: String, expiringMonth: String, expiringDay: String, expiringYear: String, streetAddress: String, cityName: String, stateName: String, zipCode: String) {
        self.userId = userId
        self.userName = userName
        self.email = email
        self.photoURL = photoURL
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.cardNumber = cardNumber
        self.cardCVV = cardCVV
        self.expiringMonth = expiringMonth
        self.expiringDay = expiringDay
        self.expiringYear = expiringYear
        self.streetAddress = streetAddress
        self.cityName = cityName
        self.stateName = stateName
        self.zipCode = zipCode
    }
    
    init(dict: [String: Any]) {
        self.userId = dict[UsersCollectionKeys.UserIdKey] as? String ?? ""
        self.userName = dict[UsersCollectionKeys.userNameKey] as? String ?? ""
        self.email = dict[UsersCollectionKeys.EmailKey] as? String ?? ""
        self.photoURL = dict[UsersCollectionKeys.PhotoURLKey] as? String ?? ""
        self.firstName = dict[UsersCollectionKeys.FirstNameKey] as? String ?? ""
        self.lastName = dict[UsersCollectionKeys.LastNameKey] as? String ?? ""
        self.password = dict[UsersCollectionKeys.passwordKey] as? String ?? ""
        self.cardNumber = dict[UsersCollectionKeys.cardNumberKey] as? String ?? ""
        self.cardCVV = dict[UsersCollectionKeys.cardCVVKey] as? String ?? ""
        self.expiringMonth = dict[UsersCollectionKeys.expiringMonthKey] as? String ?? ""
        self.expiringDay = dict[UsersCollectionKeys.expiringDayKey] as? String ?? ""
        self.expiringYear = dict[UsersCollectionKeys.expiringYearKey] as? String ?? ""
        self.streetAddress = dict[UsersCollectionKeys.streetAddressKey] as? String ?? ""
        self.cityName = dict[UsersCollectionKeys.cityNameKey] as? String ?? ""
        self.stateName = dict[UsersCollectionKeys.stateNameKey] as? String ?? ""
        self.zipCode = dict[UsersCollectionKeys.zipCodeKey] as? String ?? ""
    }
}
