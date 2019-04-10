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
    var newArray = ["Monday - 02/10/2019", "Tuesday - 02/20/2019","Wednesday - 03/5/2019",
                    "Thursday - 03/15/2019", "Friday - 03/25/2019", "Saturday - 04/01/2019",]
    var sections = ["Name", "Email", "Password","Payment", "SingOut"]
    
    private var settinTableCell = SettingTableViewCell()
    private let authservice = AppDelegate.authservice
    private var tapGRec = UITapGestureRecognizer()
    private var profileView = ProfileView()
    private var settingImage: ImageToEdit?
    private var selectedImage: UIImage?
    public var profileImage: UIImage!
    public var userSetting: CCUser!
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
        profileView.segmentedControl.addTarget(self, action: #selector(segmentedControlPress(_:)), for: .valueChanged)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "settinCell")
        tapGRec = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        profileView.profileImageView.addGestureRecognizer(tapGRec)
        profileView.profileImageView.isUserInteractionEnabled = true
        fetchUser()
        segueToRaymod()
        setupStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUser()
    }
    
    private func segueToRaymod(){
         navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueToSetting))
    }
    
    @objc private func segueToSetting(){
        let cv = CreditCardInfoSetupViewController()
        navigationController?.pushViewController(cv, animated: true)
    }
   
    func fetchUser() {
        guard let user = authservice.getCurrentUser() else {
            print("no logged user")
            return
        }
        DBService.fetchUser(userId: user.uid) {[weak self] (error, ccuser) in
            if let error = error {
                self?.showAlert(title: "Error fetching user", message: error.localizedDescription)
            } else if let ccuser = ccuser {
                self?.profileView.usernameLabel.text = "@" + user.displayName!
                self?.profileView.defaultCamera.isHidden = true
                guard let photoURl = ccuser.photoURL, !photoURl.isEmpty else {return}
                self?.profileView.profileImageView.kf.setImage(with: URL(string: photoURl))
            }
        }
    }
    
    func setUserProfileImage(selectedImage: UIImage) {
        guard let imageData = selectedImage.jpegData(compressionQuality: 1.0),
            let userAuth = authservice.getCurrentUser(),
            let _ = profileView.profileImageView.image else { return }
        
        StorageService.postImage(imageData: imageData, imageName: Constants.ProfileImagePath + userAuth.uid) { [weak self](error, url) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageUrl = url {
                let request = userAuth.createProfileChangeRequest()
                request.photoURL = URL(string: imageUrl.absoluteString)
                request.commitChanges(completion: { (error) in
                    if let error = error {
                        self?.showAlert(title: "Error Saving Account Info", message: error.localizedDescription)
                    }
                })
                DBService.firestoreDB.collection(UsersCollectionKeys.CollectionKey)
                    .document(userAuth.uid)
                    .updateData([UsersCollectionKeys.PhotoURLKey: imageUrl.absoluteString],
                                completion: {( error) in
                                    if let error = error {
                                        self?.showAlert(title: "Error Saving photo Info", message: error.localizedDescription)
                                    }
                    })
                self?.dismiss(animated: true)
            }
        }
    }
    
    private func setupStore(){
        let store = StorageInfo.init(qrcode: "name", storageID: "bbb", street: "eee", city: "www", zipCode: "wwww", state: "sss", name: "ssss", isCupon: true, cuponAmaunt: "ssss", itemBarcode: "beans")
        DBService.createStorage(storage: store) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
     @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.fetchUser()
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

    @objc func segmentedControlPress(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
    }

    func tableViewconstriant() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profileView.segmentedControl.bottomAnchor, constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    @objc func signoutButtonPress() {
        print("Was press")
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
                if section == 0 {
                return newArray.count
            }
            case 1:
                if (section == 0) {
                    return 1 }; if section == 1 { return 1 }; if section == 2 { return 1 }; if section == 3 { return 1 }; if section == 3 { return 1 }
            default:
                break
            }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch   profileView.segmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
        if profileView.segmentedControl.selectedSegmentIndex == 0 {
                cell.historyLabel.text = newArray[indexPath.row]
            } else {
                cell.historyImage.isHidden = true
                cell.historyLabel.isHidden = true
            }
            return cell
            
        case 1:
            guard let infocell = tableView.dequeueReusableCell(withIdentifier: "settinCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell()}
            if let user = authservice.getCurrentUser(){
                if indexPath.section == 0 {
                    infocell.namelLabel.text = user.displayName
                }
                if indexPath.section == 1 {
                   infocell.emailLabel.text = user.email!
                }
                if indexPath.section == 2 {
                    infocell.passwordLabel.text = "............."
                }
                if indexPath.section == 3 {
                   infocell.addCaed.text = "Add Card"
                }
                if indexPath.section == 4 {
                    infocell.signOut.text = "Sing Out"
                }
            } else {
                infocell.emailLabel.isHidden = true
            }
            return infocell
            
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileView.segmentedControl.selectedSegmentIndex {
        case 1:
            if indexPath.section == 0 {
                let alertController = UIAlertController(title: "Make changes", message: "Want to change your name?", preferredStyle: .actionSheet)
                let continueOk = UIAlertAction(title: "Continue", style: .default) { (action) in
                    let changeName = UIAlertController(title: "Changing name", message: nil, preferredStyle: .alert)
                    let change = UIAlertAction(title: "Change", style: .default, handler: { (action) in
                        let textField = changeName.textFields?[0]
                        self.profileView.usernameLabel.text = textField?.text!
                        // need to reload tableView
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in })
                    changeName.addAction(change)
                    changeName.addAction(cancel)
                    changeName.addTextField { (textFiel: UITextField) in
                        textFiel.placeholder = "change your name" }
                    self.present(changeName, animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                alertController.addAction(continueOk)
                alertController.addAction(cancel)
                present(alertController, animated: true, completion: nil)
            }
            if indexPath.section == 3 {
                let alertController = UIAlertController(title: "Payment", message: "Continue to Payment", preferredStyle: .actionSheet)
                let continueToP = UIAlertAction(title: "Continue", style: .default) { (action) in
                    self.navigationController?.pushViewController(CreditCardInfoSetupViewController(), animated: true)
                    self.dismiss(animated: true)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cation) in }
                alertController.addAction(continueToP)
                alertController.addAction(cancel)
                present(alertController, animated: true, completion: nil)
            }
            if indexPath.section == 4 {
                 let alertController = UIAlertController(title: "SignOut", message: "Proceed sign out", preferredStyle: .actionSheet)
                    let ok = UIAlertAction(title: "Continue", style: .default) { (action) in
                        self.authservice.signOutAccount()
                        self.navigationController?.pushViewController(MainTabBarController(), animated: true)
                        self.dismiss(animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cation) in }
                alertController.addAction(ok)
                alertController.addAction(cancel)
                present(alertController, animated: true, completion: nil)
              }
            default:
                break
            }
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
            guard let processedImage = resizeImage.image else { return }
            setUserProfileImage(selectedImage: processedImage)
            fetchUser()
        } else {
            print("No Image was selected for the profile")
        }
        dismiss(animated: true, completion: nil)
    }
}

