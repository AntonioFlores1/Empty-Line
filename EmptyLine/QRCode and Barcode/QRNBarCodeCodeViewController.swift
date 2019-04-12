//
//  QRNBarCodeCodeViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class QRNBarCodeCodeViewController:
UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var imageView: UIImageView!

    //    @IBOutlet weak var barCodeRawValueLabel: UILabel!
  
    //    let notification = UIStackView()

    
    var barcodeNumber = ["InsertBarCodeHere"]
    
    var bar = " "
    let session = AVCaptureSession()

    lazy var vision = Vision.vision()
  
    var barcodeDetector :VisionBarcodeDetector?

    var myView = DetailsLauncher()
 
    var productDetailsView = ProductDetailsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
//        startLiveVideo()
        

//        startLiveVideo()

=======
        startLiveVideo()
>>>>>>> 45cd21ae3c68bf3e3f49bd657cf1e713f25ca87b
        self.barcodeDetector = vision.barcodeDetector()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Product Info", style: .done, target: self, action: #selector(segue))
    }
    
    var detailsLauncher = DetailsLauncher()
        @objc func segue(){
        detailsLauncher.showSettings()
        detailsLauncher.barcodeNumber = bar
        print(detailsLauncher.barcodeNumber)
        
    }
    
    
    
    
    
    
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if let barcodeDetector = self.barcodeDetector {
            
            let visionImage = VisionImage(buffer: sampleBuffer)
            
            barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                }
                
                //
                
                if barcodes!.count == 1 {
                    
                    //
                    
                    //                    barcodes?.first?.rawValue
                    
                    self.bar = (barcodes?.first?.rawValue)!
                    
                    print(self.bar)
                    
                    //                     self.session.stopRunning()
                    
                } //else if barcodes?.count == 0 {
                
                //                    self.bar = ""
                
                //                    self.session.startRunning()
                
                //                }
                
                //                print(barcodes?.count)
                
                //                for barcode in barcodes! {
                
                //   //        self.barCodeRawValueLabel.text = barcode.rawValue!
                
                //                self.barcodeNumber[0] = barcodes.rawValue!
                
                //            print("my var \(self.barcodeNumber.)")
                
                //                    if self.barcodeNumber.count == 1 {
                
                //    self.navigationController?.pushViewController(ItemDetailViewController(), animated: true)
                
                //                        break
                
                //                    }
                
                //                }
                
                //                if barcodes!.count > 3 {
                
                //                    self.present(ItemDetailViewController(), animated: true, completion: nil)
                
                //                }
                
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
<<<<<<< HEAD
//    private func startLiveVideo() {
//        session.sessionPreset = AVCaptureSession.Preset.photo
//
//        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//
//        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
//
//        let deviceOutput = AVCaptureVideoDataOutput()
//
//        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
//
//        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
//
//        session.addInput(deviceInput)
//
//        session.addOutput(deviceOutput)
//
//        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
//
//        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height + 100)
//
//        imageLayer.videoGravity = .resizeAspectFill
//
//        imageView.layer.addSublayer(imageLayer)
//
//        session.startRunning()
//
//    }

=======
    
    
    
    
    private func startLiveVideo() {
        
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        
        
        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        
        
        
        let deviceOutput = AVCaptureVideoDataOutput()
        
        
        
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        
        
        
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        
        
        
        session.addInput(deviceInput)
        
        
        
        session.addOutput(deviceOutput)
        
        
        
        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
        
        
        
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height + 200)
        
        
        
        imageLayer.videoGravity = .resizeAspectFill
        
        
        
        imageView.layer.addSublayer(imageLayer)
        
        
        
        session.startRunning()
        
        
        
    }
    
    
    
    
>>>>>>> 45cd21ae3c68bf3e3f49bd657cf1e713f25ca87b
    
    
    
}

