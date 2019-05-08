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
import Firebase

enum ImageToEdit {
    case profileImage
}

class ProfileViewController: UIViewController {
    var sections = ["Name", "Email", "Password","Payment", "SingOut"]
    var account = ["Account", "Payment"]
    let profileIcon = [ UIImage(named: "profile"), UIImage(named: "email"), UIImage(named: "password")]
    let card = [UIImage(named: "addcard")]
    
    private var allUserCheckOutItems = [[Item]]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var allDates = [String]()
    private var allItems = [Item]()
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
    
    lazy var buttonView: UIView = {
        let buttonBar = UIView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.orange
        return buttonBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        view.addSubview(profileView)
        view.addSubview(buttonView)
        buttonView.topAnchor.constraint(equalTo: profileView.segmentedControl.bottomAnchor).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonView.leftAnchor.constraint(equalTo: profileView.segmentedControl.leftAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalTo: profileView.segmentedControl.widthAnchor, multiplier: 1 / CGFloat(profileView.segmentedControl.numberOfSegments)).isActive = true // 1
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
        tableView.tableFooterView = UIView()
        navigationItem.title = "Profile"
        profileView.usernameLabel.textColor = .black
        fetchLoggedInUserShoppingHistory()
        UIView.animate(withDuration: 0.3) {
            self.buttonView.frame.origin.x = (self.profileView.segmentedControl.frame.width / CGFloat(self.profileView.segmentedControl.numberOfSegments)) * CGFloat(self.profileView.segmentedControl.selectedSegmentIndex)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUser()
    }
    
    private func fetchLoggedInUserShoppingHistory(){
        guard let loggedInZiplineUser = authservice.getCurrentUser() else {
            showAlert(title: "Error", message: "No logged in user. Please login or create a zipline account")
            return
        }
        
        DBService.fetchzipLineUserCheckoutHistory(userID: loggedInZiplineUser.uid) { [weak self] (error, allCheckedOutItems, allCheckedoutDates) in
            if let error =  error {
                self?.showAlert(title: "Error", message: "Error \(error) encountered while fetching \(String(describing: loggedInZiplineUser.displayName)) checkout history")
            }
            if let allCheckedOutItems = allCheckedOutItems {
                
                self?.allItems = allCheckedOutItems
                
                         }
            if let allCheckedoutDates = allCheckedoutDates {
                               self?.allDates = allCheckedoutDates
                              dump(allCheckedoutDates)
                      }
            for date in self!.allDates {
                             var itemsOnDay = [Item]()
                     for item in self!.allItems {
                                    if date == item.createdAt {
                                        itemsOnDay.append(item)
                    }
                }
                self?.allUserCheckOutItems.removeAll()
                   self?.allUserCheckOutItems.append(itemsOnDay)
                                self!.tableView.reloadData()
            }
        }
    }
    
    @objc private func segueToSetting(){
        let cv = CreditCardInfoSetupViewController()
        navigationController?.pushViewController(cv, animated: true)
    }
    
    private func fetchUser() {
        guard let user = authservice.getCurrentUser()else {
            print("no logged user")
            return
        }
        DBService.fetchUser(userId: user.uid) { [weak self] (error, ccuser) in
            if let error = error {
                self?.showAlert(title: "Error fetching user", message: error.localizedDescription)
            } else if let ccuser = ccuser {
                self?.profileView.usernameLabel.text = user.displayName!
                print(ccuser.fullName)
                self?.profileView.defaultCamera.isHidden = true
                guard let photoURl = ccuser.photoURL, !photoURl.isEmpty else {return}
                self?.profileView.profileImageView.kf.setImage(with: URL(string: photoURl), placeholder: #imageLiteral(resourceName: "zipLineLogo.png"))
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
                request.photoURL = imageUrl
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
        UIView.animate(withDuration: 0.3) {
            self.buttonView.frame.origin.x = (self.profileView.segmentedControl.frame.width / CGFloat(self.profileView.segmentedControl.numberOfSegments)) * CGFloat(self.profileView.segmentedControl.selectedSegmentIndex)
        }
    }
    
    private func showImagePickerController() {
        present(imagePicker,animated: true,completion:  nil)
    }

    func tableViewconstriant() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profileView.segmentedControl.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    @objc func signoutButtonPress() {
        print("Was press")
    }
    @objc func changeNameButton() {
        print(">>>//????")
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !allUserCheckOutItems.isEmpty else { return "" }
        switch profileView.segmentedControl.selectedSegmentIndex {
        case 0:
            return allUserCheckOutItems[section].first?.createdAt
        case 1:
            return account[section]
        default:
            break
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         switch profileView.segmentedControl.selectedSegmentIndex {
         case 0:
            return allUserCheckOutItems.count
         case 1:
            return account.count
         default:
            break
        }
        return 0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !allUserCheckOutItems.isEmpty else { return 0 }
        switch profileView.segmentedControl.selectedSegmentIndex {
            case 0:
                return allUserCheckOutItems[section].count
            
            case 1:
                if (section == 0) {
                    return 3 }; if section == 1 { return 2 }; if section == 2 { return 5 }
            default:
                break
            }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch   profileView.segmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
            cell.contentView.backgroundColor = UIColor.clear
            cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 1.0
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.shadowOpacity = 0.5
            
            if profileView.segmentedControl.selectedSegmentIndex == 0 {

                if allUserCheckOutItems.count > 0 {
                    let day = allUserCheckOutItems[indexPath.section][indexPath.row]
                    print(day)
                    cell.historyLabel.text = day.name
                    cell.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
                    
                    cell.historyImage.kf.setImage(with: URL(string: day.image), placeholder:#imageLiteral(resourceName: "zipLineLogo.png") )
                } else {
                    cell.historyLabel.text = "No history of items bought"
                }
            } else {
                cell.historyImage.isHidden = true
                cell.historyLabel.isHidden = true
            }
            return cell
            
        case 1:
            guard let infocell = tableView.dequeueReusableCell(withIdentifier: "settinCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell()}
            
            if let user = authservice.getCurrentUser(){
                if indexPath.section == 0 {
                    if indexPath.row == 0 {
                        infocell.namelLabel.text = user.displayName!;
                     
                        infocell.proImage.image = profileIcon[indexPath.row]
                    } else if indexPath.row == 1 {
                        infocell.emailLabel.text = user.email!
                      
                        infocell.proImage.image = profileIcon[indexPath.row]
                    } else {
                        infocell.passwordLabel.text = "............."
                        infocell.proImage.image = profileIcon[indexPath.row]
                    }
                }
                if indexPath.section == 1{
                    if indexPath.row == 0 {
                        infocell.addCaed.text = "Add Card"
                        infocell.cardImage.image = card[indexPath.row]
                    } else {
                        infocell.signOut.text = " SignOut"
                    }
                }
            } else {
                infocell.emailLabel.isHidden = true
            }
            return infocell
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileView.segmentedControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == indexPath.row {
          
            }
            
        case 1:
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                let alertController = UIAlertController(title: "Make changes", message: "Want to change your name?", preferredStyle: .actionSheet)
                let continueOk = UIAlertAction(title: "Continue", style: .default) { (action) in
                    let changeName = UIAlertController(title: "Changing name", message: nil, preferredStyle: .alert)
                    let change = UIAlertAction(title: "Change", style: .default, handler: { (action) in
                        let textField = changeName.textFields?[0]
                        self.profileView.usernameLabel.text = textField?.text!
                        if let path = tableView.indexPathForSelectedRow {
                        let cell = tableView.cellForRow(at: path) as! SettingTableViewCell
                            cell.namelLabel.text = textField?.text!
                        }
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
            }
            if indexPath.section == 1 {
                if indexPath.row == 0 {
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
            }
            if indexPath.section == 1 {
                if indexPath.row == 1 {

                 let alertController = UIAlertController(title: "SignOut", message: "Proceed to sign out", preferredStyle: .actionSheet)
                    let ok = UIAlertAction(title: "Continue", style: .default) { (action) in
                        self.authservice.signOutAccount()
                        self.navigationController?.pushViewController(LoginViewController(), animated: true)
                        self.dismiss(animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cation) in
                    }
                alertController.addAction(ok)
                alertController.addAction(cancel)
                present(alertController, animated: true, completion: nil)
                }
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

