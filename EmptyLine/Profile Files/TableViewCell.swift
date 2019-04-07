//
//  TableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    lazy var  historyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        //        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var historyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeImage")
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setUpViewConstraints()
    }
    
    private func commonInit() {
        setUpViewConstraints()
    }
    
    func setUpViewConstraints() {
        addSubview(historyLabel)
//        addSubview(historyImage)
        historyLabelConstraints()
//        historyImageConstraints()
    }
    
    func historyLabelConstraints() {
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        historyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
//    func historyImageConstraints() {
//        historyImage.translatesAutoresizingMaskIntoConstraints = false
//        historyImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        historyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        historyImage.trailingAnchor.constraint(equalTo: historyLabel.leadingAnchor, constant: 11).isActive = true
//    }
}
