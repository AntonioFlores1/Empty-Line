//
//  ProfileView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import PureLayout


class ProfileView: UIView {
    lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "placeImage")
        imageView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 48.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var defaultCamera: UIImageView = {
        let placeCamera = UIImageView()
        placeCamera.image = UIImage(named: "camera")
        return placeCamera
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "User Name"
        label.textColor = .black
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
         view.backgroundColor = .white
        segControl.autoSetDimension(.height, toSize: 32.0)
        segControl.insertSegment(withTitle: "History", at: 0, animated: true)
        segControl.insertSegment(withTitle: "Setting", at: 1, animated: true)
        segControl.selectedSegmentIndex = 0
        view.addSubview(segControl)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        segControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segControl.backgroundColor = .clear
        segControl.tintColor = .clear
        segControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 25) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 25) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        return segControl
    }()


    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.tintColor = .gray
        button.backgroundColor = .clear
        button.autoSetDimension(.width, toSize: 96.0)
        button.autoSetDimension(.height, toSize: 32.0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        bringSubviewToFront(profileImageView)
        addSubview(segmentedControl)
        addSubview(defaultCamera)
        backgroundColor = .white
        setupConstraints()
        setnameLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 80.0)

        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        segmentedControl.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 16.0)
        
        defaultCamera.autoAlignAxis(toSuperviewAxis: .vertical)
        defaultCamera.autoPinEdge(toSuperviewEdge: .top, withInset: 170.0)
    }
    func setnameLabelConstraints() {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}



