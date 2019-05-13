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
        imageView.image =  UIImage(named: "zipLineLogo")
        imageView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 50.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var defaultCamera: UIImageView = {
        let placeCamera = UIImageView()
        placeCamera.image = UIImage(named: "camera")
        placeCamera.backgroundColor = .black
        return placeCamera
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "User Name"
<<<<<<< HEAD
        label.font = UIFont.boldSystemFont(ofSize: 17)
=======
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        
    
>>>>>>> 731885882ba7788d6ea2173b80a7307b0f0e2e34
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl()
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        containerView.backgroundColor  = .white
        segControl.autoSetDimension(.height, toSize: 32.0)
        segControl.insertSegment(withTitle: "History", at: 0, animated: true)
        segControl.insertSegment(withTitle: "Setting", at: 1, animated: true)
        segControl.selectedSegmentIndex = 0
        segControl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(segControl)
        segControl.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        segControl.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        segControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segControl.backgroundColor = .clear
        segControl.tintColor = .clear
        segControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 20) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segControl.setTitleTextAttributes([ // 25 DINCondensed-Bold
            NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 20) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor(red:0.29, green:0.60, blue:0.58, alpha:1.0)
                //UIColor.orange
            ], for: .selected)
        return segControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
<<<<<<< HEAD
        
=======
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1.0)
//        let gradient = CAGradientLayer()
        //        gradient.locations = [0.0 , 1.0]
        //        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        //        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

//let backcolor = UIColor.init(displayP3Red: 255, green: 238, blue: 219, alpha: 1)
        
         //self.backgroundColor = UIColor(hexString: "3DDC97")
        //self.backgroundColor = UIColor(hexString: "EEEEEE")
        //self.backgroundColor = UIColor(hexString: "8CD867")
         //self.backgroundColor = UIColor(hexString: "546A7B")
         //self.backgroundColor = UIColor(hexString: "9DC4B5")
          //self.backgroundColor = UIColor(hexString: "566E3D")
    //self.backgroundColor = UIColor(hexString: "566E3D")
     //self.backgroundColor = UIColor(hexString: "0C4767")
        //let gradient = CAGradientLayer()
//        self.backgroundColor = UIColor.init(displayP3Red: 34, green: 53, blue: 42, alpha: 1)
        //        gradient.locations = [0.0 , 1.0]
        //        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        //        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradient.frame = self.bounds
//        let color0 = UIColor(red:255/255, green:208/255, blue:185/255, alpha:0.5).cgColor
//        let color1 = UIColor(red:68/255, green:78/255, blue:227/255, alpha:0.5).cgColor
//        gradient.colors =     [UIColor.blue.cgColor,UIColor.red.cgColor,UIColor.orange.cgColor]
//self.layer.addSublayer(gradient)

>>>>>>> 731885882ba7788d6ea2173b80a7307b0f0e2e34
        bringSubviewToFront(profileImageView)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(defaultCamera)
        addSubview(segmentedControl)
        setupConstraints()
        setnameLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 100.0)

        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        segmentedControl.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 16.0)
        
        defaultCamera.autoAlignAxis(toSuperviewAxis: .vertical)
        defaultCamera.autoPinEdge(toSuperviewEdge: .top, withInset: 185.0)//175
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



