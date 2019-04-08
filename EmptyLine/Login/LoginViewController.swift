//
//  LoginViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountLoginState {
    case newAccount
    case existingAccount
}

class LoginViewController: UITabBarController {
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var createAccountButton: UIButton!
    private var authservice = AppDelegate.authservice
    private var accountLoginState = AccountLoginState.newAccount
    var loginView: LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        authservice.authserviceExistingAccountDelegate = self
        setupView()
    }
    
    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
            else {
                return
        }
        authservice.signInExistingAccount(email: email, password: password)
    }
}
extension LoginViewController: AuthServiceExistingAccountDelegate {
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
//        showAlert(title: "Signin Error", message: error.localizedDescription)
    }
    
    func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        mainTabBarController.modalTransitionStyle = .crossDissolve
        mainTabBarController.modalPresentationStyle = .overFullScreen
        present(mainTabBarController, animated: true)
    }
}
