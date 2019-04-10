//
//  ConfirmPaymentView.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ConfirmPaymentView: UIView {
    
    lazy var confirmPaymentTableView: UITableView = {
        let tv = UITableView()
         tv.register(ConfirmPaymentTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    lazy var totalAmount: UILabel = {
        let total = UILabel()
        total.text = "Total amount:  $"
        total.font = UIFont.systemFont(ofSize: 30)
        total.textColor = .black
        return total
    }()
    
    lazy var confirmPayment: UIButton = {
        let payment = UIButton()
        return payment
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview(totalAmount)
        addSubview(confirmPaymentTableView)
        totalAmountConstraint()
        cpTableViewConstraint()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func totalAmountConstraint() {
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        totalAmount.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        totalAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        totalAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        totalAmount.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func cpTableViewConstraint() {
        confirmPaymentTableView.translatesAutoresizingMaskIntoConstraints = false
        confirmPaymentTableView.topAnchor.constraint(equalTo: totalAmount.bottomAnchor, constant: 16).isActive = true
        confirmPaymentTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        confirmPaymentTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        confirmPaymentTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -90).isActive = true
    }
}
