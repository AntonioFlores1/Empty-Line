//
//  CreditCarview.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreditCarview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setup()
    }
    
    public lazy var loginView: UIView = {
        let actualLoginView = UIView()
        actualLoginView.backgroundColor = .blue
        return actualLoginView
    }()
    
    public lazy var loginButton: UIButton = {
        let loginButton =  UIButton()
        loginButton.titleLabel?.textColor = .blue
        loginButton.setTitle("Please Log In", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)!
        loginButton.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        //        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return loginButton
    }()
    
    public lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .none
        emailTextField.layer.cornerRadius = 5
        emailTextField.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        emailTextField.textColor = UIColor(white: 0.9, alpha: 0.8)
        emailTextField.font = UIFont.systemFont(ofSize: 17)
        var placeholder = NSMutableAttributedString()
        return emailTextField
    }()
    public lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        passwordTextField.textColor = UIColor(white: 0.9, alpha: 0.8)
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        return passwordTextField
    }()
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 200).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}



