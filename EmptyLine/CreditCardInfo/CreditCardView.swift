//
//  CreditCardView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreditCardView: UIView {

    public lazy var creditCardCredentialsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CardTypeTableViewCell.self, forCellReuseIdentifier: "CCTableViewCell")
        tableView.register(BillingNameTableViewCell.self, forCellReuseIdentifier: "BillingNameCell")
        tableView.register(CardInfoTableViewCell.self, forCellReuseIdentifier: "CardInfoCell")
        tableView.register(BillingAddressInfoTableViewCell.self, forCellReuseIdentifier: "BillingAddressCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
       
    }
    
private func commonInit(){
        setupTableViewConstrains()
    }
    private func setupTableViewConstrains(){
        addSubview(creditCardCredentialsTableView)
        creditCardCredentialsTableView.translatesAutoresizingMaskIntoConstraints = false
        creditCardCredentialsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        creditCardCredentialsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        creditCardCredentialsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        creditCardCredentialsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
