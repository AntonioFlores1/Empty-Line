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
        itemNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setItemPrice(){
        addSubview(itemPrice)
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor).isActive = true
           itemPrice.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
           itemPrice.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
         itemPrice.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
 

}
