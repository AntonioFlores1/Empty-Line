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
    
    var barcodeNumber = ""
    
    let session = AVCaptureSession()
    
    lazy var vision = Vision.vision()
    
    var barcodeDetector :VisionBarcodeDetector?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startLiveVideo()
        
        self.barcodeDetector = vision.barcodeDetector()
        
        //constraints()
        
    }
    
    func segueOnlyIf(){
        if barcodeNumber.count < 3 {
            navigationController?.popToViewController(ItemDetailViewController(), animated: true)
        }
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        
        
        if let barcodeDetector = self.barcodeDetector {
            
            
            
            let visionImage = VisionImage(buffer: sampleBuffer)
            
            
            
            barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                
                
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                }
                
                
                
                for barcode in barcodes! {
                    
                    print(barcode.rawValue!)
                    
                    self.barcodeNumber.append(barcode.rawValue!)
                   // self.barCodeRawValueLabel.text = barcode.rawValue!
                    
                }
                
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
