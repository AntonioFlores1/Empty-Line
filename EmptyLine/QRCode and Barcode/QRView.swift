//
//  QRView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class QRView: UIView {
        
        lazy var profileImageView: UIImageView = {
            var imageView = UIImageView()
            //imageView = UIImageView()
            imageView.backgroundColor = .black
            imageView.image = UIImage(named: "placeholder")
            return imageView
        }()
        
        lazy var myLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "gfklagj;ajkjgljal;jgkljaklgjlk;aj"
            label.textColor = .white
            label.backgroundColor = UIColor.black
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            imageConstraints()
            //backgroundColor = .purple
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func imageConstraints() {
    addSubview(profileImageView)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
            //        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            //        profileImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        }
        
        //    func setLabelConstraints() {
        //        myLabel.translatesAutoresizingMaskIntoConstraints = false
        //        myLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 320).isActive = true
        ////        myLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        //        myLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
        ////        myLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ////        myLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //    }
    }
