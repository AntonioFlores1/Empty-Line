//
//  ReceiptView.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/26/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptView: UIView {

    public lazy var zipLineLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "zipLineLogo")
        return imageView
    }()
    
    public lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    public lazy var totalCostLabel: UILabel = {
        let totalCostLabel = UILabel()
        return totalCostLabel
    }()
    
    public lazy var paymentStatus: UILabel = {
        let paymentStatus = UILabel()
        
        return paymentStatus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        itemsTableView.register(ReceiptTableViewCell.self, forCellReuseIdentifier: "receiptCell")
    }
    
    private func commonInit(){
        setupConstrains()
    }
    
    private func setupConstrains(){
        setupImageViewConstrains()
        setupTableViewConstrains()
        setupTotalLabelConstrains()
        statusLabelConstrains()
    }
    
    private func setupImageViewConstrains(){
        addSubview(zipLineLogo)
        zipLineLogo.translatesAutoresizingMaskIntoConstraints = false
        zipLineLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        zipLineLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        zipLineLogo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 100).isActive = true
        zipLineLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTableViewConstrains(){
        addSubview(itemsTableView)
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.topAnchor.constraint(equalTo: zipLineLogo.bottomAnchor, constant: 5).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }
    
    private func setupTotalLabelConstrains(){
        addSubview(totalCostLabel)
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCostLabel.topAnchor.constraint(equalTo: itemsTableView.bottomAnchor, constant: 5).isActive = true
        totalCostLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        totalCostLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        totalCostLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
    }
    
    
    private func statusLabelConstrains(){
        addSubview(paymentStatus)
        paymentStatus.translatesAutoresizingMaskIntoConstraints = false
        paymentStatus.topAnchor.constraint(equalTo: totalCostLabel.bottomAnchor, constant: 5).isActive = true
        paymentStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        paymentStatus.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        totalCostLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
    }
    
    
    
    
}
