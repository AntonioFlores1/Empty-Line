//
//  ScanCardViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ScanCardViewController: UIViewController {
    @IBOutlet weak var cardImageView: UIImageView!
    
    private var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpCameraAccess()

    }
    
    private func setUpCameraAccess(){
        imagePicker = UIImagePickerController()
         imagePicker.delegate = self
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    @IBAction func AddCardButtonPressed(_ sender: UIButton) {
        
        // use unwind segue to pass information back to previous view
    }
    
}

extension ScanCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
