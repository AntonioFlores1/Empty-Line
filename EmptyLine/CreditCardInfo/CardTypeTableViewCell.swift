//
//  CreditCardCredentialsTableViewCell.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CardTypeTableViewCell: UITableViewCell {
    
    public lazy var cardTypeLabel: UILabel = {
        let cardType = UILabel()
        cardType.text = "Credit/Debit Card"
        cardType.font = UIFont.systemFont(ofSize: 22)
        cardType.translatesAutoresizingMaskIntoConstraints = false
        return cardType
    }()
    
    public lazy var cardOptionsLabel: UILabel = {
        let cardOptions = UILabel()
        cardOptions.text = "Visa, MasterCard, Discover, American Express"
        cardOptions.numberOfLines = 0
        cardOptions.font = UIFont.systemFont(ofSize: 16)
        
        return cardOptions
    }()
    
    public lazy var payPalLabel: UILabel = {
        let payPalLabel = UILabel()
        payPalLabel.text = "PayPal"
       payPalLabel.font = UIFont.systemFont(ofSize: 16)
        return payPalLabel
    }()
    
    public lazy var noneLabel: UILabel = {
        let noneLabel = UILabel()
        noneLabel.text = "None"
        noneLabel.font = UIFont.systemFont(ofSize: 16)
        return noneLabel
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
        setCardTypeLabelConstrains()
        setcardOptions()
        setPayPalConstrains()
        setnoneLabelConstrains()
    }
    
    private func setCardTypeLabelConstrains(){
        addSubview(cardTypeLabel)
        NSLayoutConstraint.activate([
            cardTypeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cardTypeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11),
            cardTypeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cardTypeLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    private func setcardOptions(){
        addSubview(cardOptionsLabel)
        cardOptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        cardOptionsLabel.topAnchor.constraint(equalTo: cardTypeLabel.bottomAnchor, constant: 10).isActive = true
        cardOptionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        cardOptionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardOptionsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setPayPalConstrains(){
        addSubview(payPalLabel)
        payPalLabel.translatesAutoresizingMaskIntoConstraints = false
        payPalLabel.topAnchor.constraint(equalTo: cardOptionsLabel.bottomAnchor, constant: 10).isActive = true
        payPalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        payPalLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        payPalLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setnoneLabelConstrains(){
        addSubview(noneLabel)
        noneLabel.translatesAutoresizingMaskIntoConstraints = false
        noneLabel.topAnchor.constraint(equalTo: payPalLabel.bottomAnchor, constant: 10).isActive = true
        noneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        noneLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        noneLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
  

}
