//
//  ReceiptHistory.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptHistoryView: UIView {
    
    public lazy var receiptScrollView: UIScrollView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
        return scrollView
    }()
    
    public lazy var zipLineLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "logo")
        return imageView
    }()
    
    public lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    public lazy var totalCostLabel: UILabel = {
        let totalCostLabel = UILabel()
        totalCostLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return totalCostLabel
    }()
    
    public lazy var paymentStatus: UILabel = {
        let paymentStatus = UILabel()
        paymentStatus.font = UIFont.boldSystemFont(ofSize: 17)
        paymentStatus.text = "Payment Status: Paid"
        return paymentStatus
    }()
    
    public lazy var storeName: UILabel = {
        let storeNameLabel = UILabel()
        storeNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return storeNameLabel
    }()
    
    public lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        itemsTableView.register(ReceiptHistoryTableViewCell.self, forCellReuseIdentifier: "receiptHistory")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit(){
        setupConstrains()
    }
    
    private func setupConstrains(){
        setupScrollViewConstrains()
        setupImageViewConstrains()
        setStoreNameLabel()
        setDayLabel()
        setupTableViewConstrains()
        setupTotalLabelConstrains()
        statusLabelConstrains()
    }
    
    private func setupScrollViewConstrains(){
        addSubview(receiptScrollView)
        receiptScrollView.translatesAutoresizingMaskIntoConstraints = false
        receiptScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        receiptScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        receiptScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        receiptScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupImageViewConstrains(){
        receiptScrollView.addSubview(zipLineLogo)
        zipLineLogo.translatesAutoresizingMaskIntoConstraints = false
        zipLineLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        zipLineLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive = true
        zipLineLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80).isActive = true
        zipLineLogo.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    private func setupTableViewConstrains(){
        receiptScrollView.addSubview(itemsTableView)
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.topAnchor.constraint(equalTo: zipLineLogo.bottomAnchor, constant: 60).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
    }
    
    private func setupTotalLabelConstrains(){
        receiptScrollView.addSubview(totalCostLabel)
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCostLabel.topAnchor.constraint(equalTo: itemsTableView.bottomAnchor).isActive = true
        totalCostLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        totalCostLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        totalCostLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    private func statusLabelConstrains(){
        receiptScrollView.addSubview(paymentStatus)
        paymentStatus.translatesAutoresizingMaskIntoConstraints = false
        paymentStatus.topAnchor.constraint(equalTo: totalCostLabel.bottomAnchor).isActive = true
        paymentStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        totalCostLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        paymentStatus.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setStoreNameLabel() {
        receiptScrollView.addSubview(storeName)
        storeName.translatesAutoresizingMaskIntoConstraints = false
        storeName.topAnchor.constraint(equalTo: zipLineLogo.bottomAnchor, constant: 5).isActive = true
        storeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        storeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func setDayLabel() {
        receiptScrollView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: storeName.bottomAnchor, constant: 5).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
