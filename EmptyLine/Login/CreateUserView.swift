//
//  CreditCarview.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

//class CreateUserView: UIView {
//    private var authservice = AppDelegate.authservice
//    private var accountLoginState = AccountLoginState.newAccount
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    func setup() {
//        setupEmailTextField()
//        setupPasswordTextField()
//        setupCreateNewAccountButton()
//        
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        setup()
//    }
//    
//    public lazy var createAccountView: UIView = {
//        let actualCreateAccountView = UIView()
//        actualCreateAccountView.backgroundColor = .blue
//        return actualCreateAccountView
//    }()
//    public lazy var usernameTextField: UITextField = {
//        let usernameTextField = UITextField()
//        usernameTextField.placeholder = "UserName"
//        usernameTextField.borderStyle = .none
//        usernameTextField.layer.cornerRadius = 5
//        usernameTextField.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
//        usernameTextField.textColor = UIColor(white: 0.9, alpha: 0.8)
//        usernameTextField.font = UIFont.systemFont(ofSize: 17)
//        return usernameTextField
//    }()
//    public lazy var createNewAccountButton: UIButton = {
//        let createNewAccountButton =  UIButton()
//        createNewAccountButton.titleLabel?.textColor = .blue
//        createNewAccountButton.setTitle("Please Log In", for: .normal)
//        createNewAccountButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)!
//        createNewAccountButton.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
//        createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonPressed), for: .touchUpInside)
//        return createNewAccountButton
//    }()
//    
//    public lazy var emailTextField: UITextField = {
//        let emailTextField = UITextField()
//        emailTextField.placeholder = "Email"
//        emailTextField.borderStyle = .none
//        emailTextField.layer.cornerRadius = 5
//        emailTextField.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
//        emailTextField.textColor = UIColor(white: 0.9, alpha: 0.8)
//        emailTextField.font = UIFont.systemFont(ofSize: 17)
//        var placeholder = NSMutableAttributedString()
//        return emailTextField
//    }()
//    public lazy var passwordTextField: UITextField = {
//        let passwordTextField = UITextField()
//        passwordTextField.placeholder = "Password"
//        passwordTextField.borderStyle = .none
//        passwordTextField.layer.cornerRadius = 5
//        passwordTextField.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
//        passwordTextField.textColor = UIColor(white: 0.9, alpha: 0.8)
//        passwordTextField.font = UIFont.systemFont(ofSize: 17)
//        return passwordTextField
//    }()
//    
//        @ objc func createNewAccountButtonPressed(_ sender: UIButton) {
//            guard let email = emailTextField.text,
//            !email.isEmpty,
//            let password = passwordTextField.text,
//            !password.isEmpty,
//            let username = usernameTextField.text,
//            !username.isEmpty
//            else {
//                return
//        }
//        authservice.createNewAccount(username: username, email: email, password: password)
//    }
//    private func setupUserNameTextField() {
//        addSubview(usernameTextField)
//        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
//        usernameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
//        usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        usernameTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
//    }
//    private func setupEmailTextField() {
//        addSubview(emailTextField)
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
//        emailTextField.topAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 70).isActive = true
//        emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        emailTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
//    }
//    private func setupPasswordTextField() {
//        addSubview(passwordTextField)
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
//        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        passwordTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
//    }
//    private func setupCreateNewAccountButton() {
//        addSubview(createNewAccountButton)
//        createNewAccountButton.translatesAutoresizingMaskIntoConstraints = false
//        createNewAccountButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 200).isActive = true
//        createNewAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        createNewAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        createNewAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//}
//
//
//
