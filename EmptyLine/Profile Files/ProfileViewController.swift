//
//  ProfileViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import PureLayout
import Toucan
import Kingfisher

enum ImageToEdit {
    case profileImage
}
enum SwitchButton {
    case history
    case setting
}

class ProfileViewController: UIViewController {
    var newArray = ["Whole foods - $200",
                    "Macy's - $150",
                    "Pharmacy -  $23",
                    "American Express Centurion Lounge - $45",
                    "MTA - $10",
                    "Yoga Studio - $18",]

    
    private var profileView = ProfileView()
    private var settingImage: ImageToEdit?
    private var settingButton: SwitchButton?
    private var selectedImage: UIImage?
    
    static var authservice = AppDelegate.authservice
    
    private var userInfo = [CCUser]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        tableView.dataSource = self
        tableViewconstriant()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueforRaymond))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueToSetting))
        profileView.editButton.addTarget(self, action: #selector(editButtonPressw), for: .touchUpInside)
        profileView.editButton.addTarget(self, action: #selector(historyButtonPress), for: .touchUpInside)
        profileView.editButton.addTarget(self, action: #selector(settingButtonPress), for: .touchUpInside)
    }
    
    @objc func editButtonPressw() {
        print("Press")
        settingImage = .profileImage
        let alertController = UIAlertController(title: "Edit Profile", message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.showImagePickerController()
        }
        let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.showImagePickerController()
        }
        let nameToEdit = UIAlertAction(title: "Change your name", style: .default) { (action) in
            let textFieldAlert = UIAlertController(title: "Change your name", message: "Enter your name", preferredStyle: .alert)
            textFieldAlert.addTextField(configurationHandler: { (email: UITextField) in
                // code will be here
                email.placeholder = "enter your name"
            })
            let change = UIAlertAction(title: "Change", style: .default, handler: { (action) in
                let name = textFieldAlert.textFields![0] as! UITextField
                self.profileView.nameLabel.text = name.text
                self.dismiss(animated: true, completion: nil)
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            textFieldAlert.addAction(change)
            textFieldAlert.addAction(cancel)
            self.present(textFieldAlert, animated: true, completion: nil)
            //=====--
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (action) in
        }
        alertController.addAction(camera)
        alertController.addAction(cancel)
        alertController.addAction(photoLibrary)
        alertController.addAction(nameToEdit)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func historyButtonPress() {
    
    }
    @objc func settingButtonPress() {
        
    }
    
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
    }
    
    @objc func segueforRaymond(){
        navigationController?.pushViewController(CreditCardInfoSetupViewController(), animated: true)
    }
    @objc func segueToSetting() {
        if settingButton == .setting {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }
    
    func tableViewconstriant() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profileView.segmentedControl.bottomAnchor, constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if settingButton == .history {
        return newArray.count
        } else {
            return newArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
        cell.historyLabel.text = "\(newArray[indexPath.row])"
        return cell
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("original image not available")
            return }
        let imageSize = CGSize(width: 500, height: 500)
        let resizeImage = Toucan.init(image: originalImage).resize(imageSize)
        if settingImage == .profileImage {
            selectedImage = resizeImage.image
            profileView.profileImageView.image = resizeImage.image
        } else {
            print("No Image was selected for the profile")
        }
        dismiss(animated: true, completion: nil)
    }
}
