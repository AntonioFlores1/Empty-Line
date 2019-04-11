//
//  AuthService.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthServiceCreateNewAccountDelegate: AnyObject {
    func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error)
    func didCreateNewAccount(_ authservice: AuthService, user: CCUser)
}

protocol AuthServiceExistingAccountDelegate: AnyObject {
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error)
    func didSignInToExistingAccount(_ authservice: AuthService, user: User)
}

protocol AuthServiceSignOutDelegate: AnyObject {
    func didSignOutWithError(_ authservice: AuthService, error: Error)
    func didSignOut(_ authservice: AuthService)
}

final class AuthService {
    weak var authserviceCreateNewAccountDelegate: AuthServiceCreateNewAccountDelegate?
    weak var authserviceExistingAccountDelegate: AuthServiceExistingAccountDelegate?
    weak var authserviceSignOutDelegate: AuthServiceSignOutDelegate?
    
    public func createNewAccount(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
                return
            } else if let authDataResult = authDataResult {
                print("we got a result yay")
                // update displayName for auth user
                let request = authDataResult.user.createProfileChangeRequest()
                request.displayName = username
                request.commitChanges(completion: { (error) in
                    if let error = error {
                        self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
                        return
                    }
                })
                
                // create user (reviewer) on firestore database
                
                let appUser = CCUser.init(userId: authDataResult.user.uid, userName: "", email: authDataResult.user.email!, photoURL: nil, firstName: "", lastName: "", password: "", cardNumber: "", cardCVV: "", expiringMonth: "", expiringDay: "", expiringYear: "", streetAddress: "", cityName: "", stateName: "", zipCode: "")
                
                DBService.createNDUser(user: appUser, completion: { (error) in
                    print("this is the completion of creating a user")
                    if let error = error {
                        print("this is the error shit")
                        self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
                    } else {
                        print("sup bro")
                        self.authserviceCreateNewAccountDelegate?.didCreateNewAccount(self, user: appUser)
                    }
                })
            }
        }
    }
    
    public func signInExistingAccount(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.authserviceExistingAccountDelegate?.didRecieveErrorSigningToExistingAccount(self, error: error)
            } else if let authDataResult = authDataResult {
                self.authserviceExistingAccountDelegate?.didSignInToExistingAccount(self, user: authDataResult.user)
            }
        }
    }
    
    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func signOutAccount() {
        do {
            try Auth.auth().signOut()
            authserviceSignOutDelegate?.didSignOut(self)
        } catch {
            authserviceSignOutDelegate?.didSignOutWithError(self, error: error)
        }
    }
}
