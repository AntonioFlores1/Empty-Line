//
//  TableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    lazy var  historyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var historyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        return image
    }()
    
//    lazy var  namelLabel: UILabel = {
//        let name = UILabel()
//        name.textColor = .black
//        return name
//    }()
//
//    lazy var  emailLabel: UILabel = {
//        let email = UILabel()
//        email.textColor = .black
//        return email
//    }()
//
//    lazy var  passwordLabel: UILabel = {
//        let pass = UILabel()
//        pass.textColor = .black
//        return pass
//    }()
    
//    lazy var signOut: UIButton = {
//        let out = UIButton()
//        return out
//    }()

    
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
        addSubview(historyLabel)
        addSubview(historyImage)
//        addSubview(emailLabel)
//        addSubview(namelLabel)
//        addSubview(passwordLabel)
//        addSubview(signOut)
        historyLabelConstraints()
        historyImageConstraints()
//        emailConstraints()
//        nameLabelConstraints()
//        passwordLabelConstraints()
    }
    
    func historyLabelConstraints() {
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: historyImage.trailingAnchor, constant: 10).isActive = true
        historyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    func historyImageConstraints() {
        historyImage.translatesAutoresizingMaskIntoConstraints = false
        historyImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        historyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        historyImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -300).isActive = true
        historyImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        historyImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        historyImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
//    func emailConstraints() {
//        emailLabel.translatesAutoresizingMaskIntoConstraints = false
//        emailLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//    }
//    func nameLabelConstraints() {
//        namelLabel.translatesAutoresizingMaskIntoConstraints = false
//        namelLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        namelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        namelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//    }
//    func passwordLabelConstraints() {
//        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
//        passwordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//    }
//    func sigOutonstraints() {
//        signOut.translatesAutoresizingMaskIntoConstraints = false
//        signOut.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        signOut.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        signOut.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//    }
}
