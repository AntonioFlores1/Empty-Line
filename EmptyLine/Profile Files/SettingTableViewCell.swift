//
//  SettingTableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    lazy var  namelLabel: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 15)
        name.backgroundColor = .white
        return name
    }()
    
    lazy var  emailLabel: UILabel = {
        let email = UILabel()
        email.textColor = .black
        email.font = UIFont.systemFont(ofSize: 15)
        email.backgroundColor = .white
        return email
    }()
    
    lazy var  passwordLabel: UILabel = {
        let pass = UILabel()
        pass.font = UIFont.systemFont(ofSize: 25)
        pass.backgroundColor = .white
        pass.textColor = .black
        return pass
    }()
    
    lazy var addCaed: UILabel = {
        let card = UILabel()
        card.textColor = .black
        card.backgroundColor = .white
        card.font = UIFont.systemFont(ofSize: 15)
        return card
    }()
    
    lazy var signOut: UILabel = {
        let out = UILabel()
        out.textColor = .black
        out.textAlignment = .center
        out.backgroundColor = .white
        out.font = UIFont.systemFont(ofSize: 15)
        out.alpha = 0.5
        return out
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setUpViewConstraints()
    }
    
    private func commonInit() {
        setUpViewConstraints()
    }
    
    func setUpViewConstraints() {
        addSubview(emailLabel)
        addSubview(namelLabel)
        addSubview(passwordLabel)
        addSubview(addCaed)
        addSubview(signOut)
        emailConstraints()
        nameLabelConstraints()
        passwordLabelConstraints()
        addCardConstraints()
        signOutConstraints()
       
        
    }
    func emailConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func nameLabelConstraints() {
        namelLabel.translatesAutoresizingMaskIntoConstraints = false
        namelLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        namelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        namelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func passwordLabelConstraints() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func addCardConstraints() {
        addCaed.translatesAutoresizingMaskIntoConstraints = false
        addCaed.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addCaed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        addCaed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func signOutConstraints() {
        signOut.translatesAutoresizingMaskIntoConstraints = false
        signOut.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        signOut.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        signOut.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
}
