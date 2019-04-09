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
//    lazy var profileImageView: UIImageView = {
//        var imageView = UIImageView()
//        imageView.backgroundColor = .black
//        imageView.image = UIImage(named: "placeImage")
//        imageView.autoSetDimensions(to: CGSize(width: 128.0, height: 128.0))
//        imageView.layer.borderWidth = 3.0
//        imageView.layer.borderColor = UIColor.green.cgColor
//        imageView.layer.cornerRadius = 64.0
//        imageView.clipsToBounds = true
//        return imageView
//    }()
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
//    lazy var editButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Edit", for: .normal)
//        button.setTitleColor(.gray, for: .normal)
//        button.layer.cornerRadius = 4.0
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.layer.borderWidth = 1.0
//        button.tintColor = .gray
//        button.backgroundColor = .clear
//        button.autoSetDimension(.width, toSize: 96.0)
//        button.autoSetDimension(.height, toSize: 32.0)
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        addSubview(profileImageView)
//        addSubview(nameLabel)
//        bringSubviewToFront(profileImageView)
//        addSubview(segmentedControl)
//        addSubview(editButton)
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
//        profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
//        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 100.0)
//        
//        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
//        segmentedControl.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16.0)
//        
//        editButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//        editButton.autoPinEdge(toSuperviewEdge: .right, withInset: 1.0)
//    }
//    func setnameLabelConstraints() {
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
//}
