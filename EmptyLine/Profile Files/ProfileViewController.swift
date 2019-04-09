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

class ProfileViewController: UIViewController {
    var newArray = ["Monday - 02/10/2019",
                    "Tuesday - 02/20/2019",
                    "Wednesday - 03/5/2019",
                    "Thursday - 03/15/2019",
                    "Friday - 03/25/2019",
                    "Saturday - 04/01/2019",]
    
    var array = ["Monday",
                    "Tuesday",
                    "Wednesday ",
                    "Thursday"]
    
    private var profileView = ProfileView()
    private var settingImage: ImageToEdit?
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
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableViewconstriant()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueforRaymond))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueToSetting))
        profileView.segmentedControl.addTarget(self, action: #selector(segmentedControlPress(_:)), for: .valueChanged)
    }
    
    
    @objc func segmentedControlPress(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
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
    
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
    }     
        let cv = CreditCardInfoSetupViewController()
navigationController?.pushViewController(cv, animated: true)

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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileView.segmentedControl.selectedSegmentIndex {
        case 0:
            return newArray.count
        case 1:
            return array.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let info = userInfo[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
            switch profileView.segmentedControl.selectedSegmentIndex {
            case 0:
                cell.historyLabel.text = newArray[indexPath.row]
            case 1:
               cell.historyLabel.text = array[indexPath.row]
            default:
                break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
