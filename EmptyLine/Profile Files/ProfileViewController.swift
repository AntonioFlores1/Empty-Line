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
    var newA = ["Monday - 02/10/2019",
                    "Tuesday - 02/20/2019",
                    "Wednesday - 03/5/2019",]
    
    var sections = ["Name", "Email", "Password","Payment", "SingOut"]
    
    var tapGRec = UITapGestureRecognizer()
    private var profileView = ProfileView()
    private var settingImage: ImageToEdit?
    private var selectedImage: UIImage?

    
    private let authservice = AppDelegate.authservice
    public var username: CCUser!
    private var userHistoryInfo = [CCUser]() {
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
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "settinCell")
        profileView.segmentedControl.addTarget(self, action: #selector(segmentedControlPress(_:)), for: .valueChanged)
        tapGRec = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        profileView.profileImageView.addGestureRecognizer(tapGRec)
        profileView.profileImageView.isUserInteractionEnabled = true
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUser()
    }
    func fetchUser() {
        guard let user = authservice.getCurrentUser() else {
            print("no logged user")
            return
        }
        DBService.fetchUser(userId: user.uid) { (error, ccuser) in
            if let error = error {
                self.showAlert(title: "Error fetching user", message: error.localizedDescription)
            } else if let ccuser = ccuser {
                self.profileView.usernameLabel.text = ccuser.fullName
                self.username = ccuser
                guard let photoURl = ccuser.photoURL, !photoURl.isEmpty else {return}
                self.profileView.profileImageView.kf.setImage(with: URL(string: photoURl))
            }
        }
    }
    
     @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        print("Tap")
        settingImage = .profileImage
        let alertController = UIAlertController(title: "Edit Profile", message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.showImagePickerController()
            self.profileView.defaultCamera.isHidden = true
        }
        let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.showImagePickerController()
            self.profileView.defaultCamera.isHidden = true
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(camera)
        alertController.addAction(cancel)
        alertController.addAction(photoLibrary)
        present(alertController, animated: true, completion: nil)

    }
    
<<<<<<< HEAD
    @objc func segmentedControlPress(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
=======
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
    }     
        let cv = CreditCardInfoSetupViewController()
navigationController?.pushViewController(cv, animated: true)

>>>>>>> 27e8bb348dccae71c75748df4ab1ce3eb9e998c6
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch profileView.segmentedControl.selectedSegmentIndex {
            case 0:
                return ""
            case 1:
                return sections[section]
            default:
                break
            }
        return ""
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileView.segmentedControl.selectedSegmentIndex {
            case 0:
                return newArray.count
            case 1:
                if (section == 0) {
                    return 1 }; if section == 1 { return 1 }; if section == 2 { return 1 }; if section == 3 { return 1 }
            default:
                break
            }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
            switch profileView.segmentedControl.selectedSegmentIndex {
                case 0:
                    cell.historyLabel.text = newArray[indexPath.row]
                case 1:
                    cell.historyImage.isHidden = true
                default:
                    break
                }
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
