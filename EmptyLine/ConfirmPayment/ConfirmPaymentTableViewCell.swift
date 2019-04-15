//
//  ConfirmPaymentTableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ConfirmPaymentTableViewCell: UITableViewCell {
    
    lazy var switchOnOff: UISwitch = {
    let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
    switchOnOff.setOn(false, animated: false)
        return switchOnOff
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "card")
        return image
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
        addSubview(switchOnOff)
        addSubview(cardImage)
        setSecondCB()
        cardImageConstraint()
    }
    
    func setSecondCB() {
        switchOnOff.translatesAutoresizingMaskIntoConstraints = false
        switchOnOff.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        switchOnOff.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 320).isActive = true
        switchOnOff.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
        switchOnOff.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    func cardImageConstraint() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        cardImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -300).isActive = true
        cardImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
