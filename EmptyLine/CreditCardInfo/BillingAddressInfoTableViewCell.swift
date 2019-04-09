//
//  BillingAddressInfoTableViewCell.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class BillingAddressInfoTableViewCell: UITableViewCell {
    
    public lazy var streetName: UITextField = {
        let streetName = UITextField()
        streetName.placeholder = "Enter Street"
        streetName.translatesAutoresizingMaskIntoConstraints = false
        return streetName
    }()
    
    public lazy var cityName: UITextField = {
        let cityName = UITextField()
        cityName.placeholder = "Enter City"
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.layer.cornerRadius = 5
        return cityName
    }()
    
    public lazy var stateAddress: UITextField = {
        let stateAddress = UITextField()
        stateAddress.placeholder = "Enter State"
        stateAddress.layer.cornerRadius = 5
        stateAddress.translatesAutoresizingMaskIntoConstraints = false
        return stateAddress
    }()
    
    public lazy var zipCode: UITextField = {
        let zipCode = UITextField()
        zipCode.placeholder = "Enter ZipCode"
        zipCode.translatesAutoresizingMaskIntoConstraints = false
        return zipCode
    }()
    
    public lazy var phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.placeholder = "Enter Phone Number"
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumber
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
        setConstrains()
      
    }
    
    private func setConstrains(){
        setupStreet()
        setupCityName()
        setupState()
        setupZipCode()
        setupPhoneNumber()
    }
    
    private func setupStreet(){
        addSubview(streetName)
        streetName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        streetName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        streetName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        streetName.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupCityName(){
        addSubview(cityName)
        cityName.topAnchor.constraint(equalTo: streetName.bottomAnchor, constant: 5).isActive = true
        cityName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityName.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupState(){
        addSubview(stateAddress)
        stateAddress.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 5).isActive = true
        stateAddress.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stateAddress.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stateAddress.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupZipCode(){
        addSubview(zipCode)
        zipCode.topAnchor.constraint(equalTo: stateAddress.bottomAnchor, constant: 5).isActive = true
        zipCode.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        zipCode.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        zipCode.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupPhoneNumber(){
        addSubview(phoneNumber)
        phoneNumber.topAnchor.constraint(equalTo: zipCode.bottomAnchor, constant: 5).isActive = true
        phoneNumber.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        phoneNumber.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
