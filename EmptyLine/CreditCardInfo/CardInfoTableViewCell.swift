//
//  CardInfoTableViewCell.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CardInfoTableViewCell: UITableViewCell {

    
    public lazy var cardNumberTextField: UITextField = {
        let cardNumberTextField = UITextField()
        cardNumberTextField.placeholder = "Enter Card Number"
        cardNumberTextField.layer.cornerRadius = 5
        cardNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        return cardNumberTextField
    }()
    
    public lazy var cvvTextField: UITextField = {
        let cvvTextField = UITextField()
        cvvTextField.placeholder = "Enter Card Security Code e.g CVV"
        cvvTextField.translatesAutoresizingMaskIntoConstraints = false
        cvvTextField.layer.cornerRadius = 5
        return cvvTextField
    }()
    
    public lazy var expiringMonth: UITextField = {
        let month = UITextField()
        month.placeholder = "Month |"
        month.translatesAutoresizingMaskIntoConstraints = false
        return month
    }()
    
    public lazy var expiringDay: UITextField = {
        let day = UITextField()
        day.placeholder = "Day |"
        day.translatesAutoresizingMaskIntoConstraints = false
        return day
    }()
    
    public lazy var expiringYear: UITextField = {
        let year = UITextField()
        year.placeholder = "Year"
        year.translatesAutoresizingMaskIntoConstraints = false
        return year
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
       setupCardNumberTextField()
        setupCardCVVTextField()
        setMonthTextField()
        setDayTextField()
        setYearTextField()
        
    }
    
    private func setupCardNumberTextField(){
        addSubview(cardNumberTextField)
        
        cardNumberTextField.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        cardNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cardNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    private func setupCardCVVTextField(){
        addSubview(cvvTextField)
        cvvTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 5).isActive = true
        cvvTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cvvTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cvvTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setMonthTextField(){
        addSubview(expiringMonth)
        expiringMonth.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: 5).isActive = true
        expiringMonth.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        expiringMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setDayTextField(){
        addSubview(expiringDay)
        expiringDay.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: 5).isActive = true
        expiringDay.leadingAnchor.constraint(equalTo: expiringMonth.trailingAnchor, constant: 5).isActive = true
        expiringDay.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setYearTextField(){
        addSubview(expiringYear)
        expiringYear.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: 5).isActive = true
        expiringYear.leadingAnchor.constraint(equalTo: expiringDay.trailingAnchor, constant: 5).isActive = true
        expiringYear.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}
