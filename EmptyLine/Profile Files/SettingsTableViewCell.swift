////
////  SettingsTableViewCell.swift
////  EmptyLine
////
////  Created by Pursuit on 4/5/19.
////  Copyright © 2019 Pursuit. All rights reserved.
////
//
//import UIKit
//
//class SettingsTableViewCell: UITableViewCell {
//
//    lazy var  namelLabel: UILabel = {
//        let email = UILabel()
//        email.textColor = .black
//        return email
//    }()
//    
//    lazy var  emailLabel: UILabel = {
//        let email = UILabel()
//        email.textColor = .black
//        return email
//    }()
//    
//    lazy var  passwordLabel: UILabel = {
//        let email = UILabel()
//        email.textColor = .black
//        return email
//    }()
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        commonInit()
//        setUpViewConstraints()
//    }
//    
//    private func commonInit() {
//        setUpViewConstraints()
//    }
//    
//    func setUpViewConstraints() {
//        addSubview(emailLabel)
//        addSubview(namelLabel)
//        addSubview(passwordLabel)
//        cardConstraints()
//    }
//    func cardConstraints() {
//        emailLabel.translatesAutoresizingMaskIntoConstraints = false
//        emailLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//    }
//
//}
