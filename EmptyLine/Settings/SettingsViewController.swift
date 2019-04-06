//
//  SettingsViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var settingView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingView)
        self.view.backgroundColor = .white
        setuserImageUI()
    }
    
    private func setuserImageUI() {
        settingView.profileImageView.layer.cornerRadius = 50
        settingView.profileImageView.clipsToBounds = true
        settingView.profileImageView.layer.borderColor = UIColor.black.cgColor
        settingView.profileImageView.layer.borderWidth = 1
    }
}
