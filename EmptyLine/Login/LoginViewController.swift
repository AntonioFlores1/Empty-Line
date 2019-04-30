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

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createNewAccountButton: UIButton!
    
    private var authservice = AppDelegate.authservice
    private var accountLoginState = AccountLoginState.newAccount

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        authservice.authserviceExistingAccountDelegate = self
        self.hideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        
       UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
                    animations: {
                    self.emailTextField.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [],
                       animations: {
                        self.passwordTextField.center.x += self.view.bounds.width
        },
                       completion: nil
        )
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
    @IBAction func createNewAccountButtonPressed(_ sender: UIButton) {
            print("it's working")
    }
}
    

extension LoginViewController: AuthServiceExistingAccountDelegate {
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
        showAlert(title: "Signin Error", message: error.localizedDescription)
    }
    
    func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainPageTabBarController") as! UITabBarController
        mainTabBarController.modalTransitionStyle = .crossDissolve
        mainTabBarController.modalPresentationStyle = .overFullScreen
        present(mainTabBarController, animated: true)
    }
}
extension LoginViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(LoginViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
