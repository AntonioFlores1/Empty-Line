//
//  ReceiptView.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/26/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptView: UIView {
    
    
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
        imageView.image = UIImage.init(named: "zipLineLogo")
        return imageView
    }()
    
    public lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    public lazy var totalCostLabel: UILabel = {
        let totalCostLabel = UILabel()
        totalCostLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return totalCostLabel
    }()
    
    public lazy var paymentStatus: UILabel = {
        let paymentStatus = UILabel()
        paymentStatus.font = UIFont.boldSystemFont(ofSize: 20)
        paymentStatus.text = "Payment Status: Paid"
        return paymentStatus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
         itemsTableView.register(ReceiptTableViewCell.self, forCellReuseIdentifier: "receiptCell")
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
        zipLineLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        zipLineLogo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        zipLineLogo.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupTableViewConstrains(){
        receiptScrollView.addSubview(itemsTableView)
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.topAnchor.constraint(equalTo: zipLineLogo.bottomAnchor).isActive = true
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
    
    
    
    
}
