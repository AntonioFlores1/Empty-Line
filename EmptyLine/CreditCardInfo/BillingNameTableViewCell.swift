//
//  BillingNameTableViewCell.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class BillingNameTableViewCell: UITableViewCell {
    
    public lazy var firstNameTextField: UITextField = {
        let firstName = UITextField()
        firstName.placeholder = "Enter first name"
        firstName.layer.cornerRadius = 5
        firstName.translatesAutoresizingMaskIntoConstraints = false
        return firstName
    }()
    
    public lazy var lastNameTextField: UITextField = {
        let lastName = UITextField()
        lastName.placeholder = "Enter last name"
        lastName.translatesAutoresizingMaskIntoConstraints = false
        lastName.layer.cornerRadius = 5
        return lastName
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setupConstrains()
    }
    
    private func setupConstrains(){
        setupFirstNameTextField()
        setupLastNameTextField()
       
    }
    
    private func setupFirstNameTextField(){
        addSubview(firstNameTextField)
        firstNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupLastNameTextField(){
        addSubview(lastNameTextField)
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lastNameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }

}
