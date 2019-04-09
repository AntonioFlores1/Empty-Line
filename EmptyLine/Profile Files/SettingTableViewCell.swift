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
        return name
    }()
    
    lazy var  emailLabel: UILabel = {
        let email = UILabel()
        email.textColor = .black
        return email
    }()
    
    lazy var  passwordLabel: UILabel = {
        let pass = UILabel()
        pass.textColor = .black
        return pass
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
        emailConstraints()
        nameLabelConstraints()
        passwordLabelConstraints()
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
}
