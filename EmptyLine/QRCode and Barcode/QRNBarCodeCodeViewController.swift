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

class QRNBarCodeCodeViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{
 
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var barCodeRawValueLabel: UILabel!
    
//    let notification = UIStackView()
    
    var barcodeNumber = ["InsertBarCodeHere"]
    var bar = ""
    
    let session = AVCaptureSession()
    
    lazy var vision = Vision.vision()
    
    var barcodeDetector :VisionBarcodeDetector?
    
    var myView = DetailsLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        startLiveVideo()
        

        startLiveVideo()

        self.barcodeDetector = vision.barcodeDetector()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(segue))
    }
    
    var detailsLauncher = DetailsLauncher()
    @objc func segue(){
      detailsLauncher.showSettings()
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
//                if barcodes!.count == 1 {
//                    self.bar = (barcodes?.first?.rawValue)!
//                    print(self.bar)
//                } else if barcodes?.count == 0 {
//                    self.bar = ""
//                }
              //  print(barcodes?.count)
//                for barcode in barcodes! {
//   //        self.barCodeRawValueLabel.text = barcode.rawValue!
//            self.barcodeNumber[0] = barcode.rawValue!
//            print("my var \(self.barcodeNumber.count)")
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
        
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height + 100)
        
        imageLayer.videoGravity = .resizeAspectFill
        
        imageView.layer.addSublayer(imageLayer)
        
        session.startRunning()
        
    }

    
    
    
}
