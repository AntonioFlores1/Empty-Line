//
//  SettingsView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

//import UIKit
//
//class SettingsView: UIView {
//    
//    lazy var nameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.text = "User Name"
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var segmentedControl: UISegmentedControl = {
//        let control = UISegmentedControl(items: ["History","Setting"])
//        control.autoSetDimension(.height, toSize: 32.0)
//        control.selectedSegmentIndex = 0
//        control.layer.borderColor = UIColor.gray.cgColor
//        control.tintColor = .gray
//        return control
//    }()
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//
//        addSubview(nameLabel)
//        addSubview(segmentedControl)
//
//        backgroundColor = .white
//        setupConstraints()
//        setnameLabelConstraints()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupConstraints() {
//        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
//        segmentedControl.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16.0)
//    }
//    func setnameLabelConstraints() {
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
//}
