//
//  TableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    public lazy var  shoppingDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var shopNameLabel: UILabel = {
        let label = UILabel()
        label.text = "WHOLE FOODS SUPERMARKET"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        setUpViewConstraints()
    }
    
    private func setUpViewConstraints() {
        historyLabelConstraints()
        setShopNameLabel()
        
    }
    
    private func historyLabelConstraints() {
        addSubview(shoppingDateLabel)
        shoppingDateLabel.translatesAutoresizingMaskIntoConstraints = false
        shoppingDateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        shoppingDateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        shoppingDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 11).isActive = true
        //shoppingDateLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    private func setShopNameLabel(){
        addSubview(shopNameLabel)
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.topAnchor.constraint(equalTo: shoppingDateLabel.bottomAnchor, constant: 0).isActive = true
        shopNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        shopNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 11).isActive = true
        shopNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
    }
    
}
