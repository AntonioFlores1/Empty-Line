//
//  ConfirmPaymentTableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ConfirmPaymentTableViewCell: UITableViewCell {
    
    lazy var secondCardButton: UIButton = {
        let secondCb = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        secondCb.backgroundColor = .red
        secondCb.setTitle("secod", for: .normal)
        return secondCb
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setUpConstraints()
    }
    private func commonInit() {
        setUpConstraints()
    }
    private func setUpConstraints() {
        addSubview(secondCardButton)
        
        setSecondCB()
    }
    
    func setSecondCB() {
        secondCardButton.translatesAutoresizingMaskIntoConstraints = false
        secondCardButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        secondCardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 300).isActive = true
        secondCardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
        secondCardButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
}
