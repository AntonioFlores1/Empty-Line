//
//  QRNBarCodeCodeViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

class QRNBarCodeCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate{
    
//    var video = AVCaptureVideoPreviewLayer()
//    var QRcodeView = QRView()
//
////    lazy var tableView: UITableView = {
////        var table = UITableView()
////        table.allowsMultipleSelection = true
////
////     return table
////    }()
//
//    lazy var imageQR: UIImageView = {
//        var image = UIImageView()
//        image.image = UIImage(named: "c4ee97a3-1c5f-4e27-912c-48b30dff9c3d")
//        return image
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        constraints()
////        self.view.addSubview(QRcodeView)
//        self.view.backgroundColor = .blue
//        let session = AVCaptureSession()
//        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//        do {
//            let input = try AVCaptureDeviceInput(device: captureDevice!)
//            session.addInput(input)
//        }catch {
//          print("Error")
//        }
//
//        let outPut = AVCaptureMetadataOutput()
//        session.addOutput(outPut)
//        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        outPut.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//        video = AVCaptureVideoPreviewLayer(session: session)
//        video.frame = view.layer.bounds
//        view.layer.addSublayer(video)
//        //view.bringSubviewToFront(<#T##view: UIView##UIView#>)
//        session.startRunning()
//
//
//            }
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        if metadataObjects != nil && metadataObjects.count != nil {
//            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
//                if object.type == AVMetadataObject.ObjectType.qr {
//                    print("I work")
//                }
//            }
//        }
//    }
//
//
//    func constraints(){
//        self.view.addSubview(imageQR)
//        imageQR.translatesAutoresizingMaskIntoConstraints = false
//        imageQR.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 140.0).isActive = true
//        imageQR.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 140.0).isActive = true
//        imageQR.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageQR.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
   

}
