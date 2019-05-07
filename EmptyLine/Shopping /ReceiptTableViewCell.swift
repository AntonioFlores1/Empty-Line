//
//  ReceiptTableViewCell.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/26/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    public lazy var itemNameLabel: UILabel = {
        let itemNameLabel = UILabel()
        return itemNameLabel
    }()
    
    public lazy var itemPrice: UILabel = {
        let itemPrice = UILabel()
        return itemPrice
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInt()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInt()
    }
    
    private func commonInt(){
        setConstrains()
    }
    
    private func setConstrains(){
        setItemNameLabelConstrains()
        setItemPrice()
    }
    
    private func setItemNameLabelConstrains(){
        addSubview(itemNameLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setItemPrice(){
        addSubview(itemPrice)
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        itemPrice.leadingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor, constant: -20).isActive = true
        itemPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
        itemPrice.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
