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

//        @IBOutlet weak var barCodeRawValueLabel: UILabel!
        var barCodeRawValueLabel: UILabel!
  
    //    let notification = UIStackView()

    var barcodeNumber = ["InsertBarCodeHere"]
    
    var bar = ""
    
    let session = AVCaptureSession()
    lazy var vision = Vision.vision()
    var barcodeDetector :VisionBarcodeDetector?
    var myView = DetailsLauncher()
    var productDetailView = ProductDetailsView()
    private var products:Item?
    private var barCodeNumber: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLiveVideo()
        setupView()
        addToShoppingCart()
        fetchProduct(barCode: "04965802")
        

        self.barcodeDetector = vision.barcodeDetector()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Product Info", style: .done, target: self, action: #selector(segue))
    }
    
    //var detailsLauncher = DetailsLauncher()
    
   // private var details = ProductDetailViewController()
    
        @objc func segue(){
            
        //detailsLauncher.showSettings()
        //detailsLauncher.barcodeNumber = bar
        //print(detailsLauncher.barcodeNumber)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if let barcodeDetector = self.barcodeDetector {
            let visionImage = VisionImage(buffer: sampleBuffer)
            barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if barcodes!.count == 1 {
//                    barcodes?.first?.rawValue
                    self.bar = (barcodes?.first?.rawValue)!
                    print(self.bar)
//                    self.session.stopRunning()
//
                } //else if barcodes?.count == 0 {
//
//                                    self.bar = ""
//                                    self.session.startRunning()
//                                }

//                                for barcode in barcodes! {
//                           self.bar = barcode.rawValue!
////                                self.barcodeNumber[0] = barcode.rawValue!
//                                    print(self.bar)
//
                }
                                    //                                  }  if self.barcodeNumber.count == 1 {
//
//                    self.navigationController?.pushViewController(ItemDetailViewController(), animated: true)
//
//                                        break
//
//                                    }
//
//                                }
//
//                                if barcodes!.count > 3 {
//
//                                    self.present(ItemDetailViewController(), animated: true, completion: nil)
//
                }

        
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
            
    


        
        
    public func setupView(){
        
        if let window = UIApplication.shared.keyWindow {
            view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(productDetailView)
            
            
            let height: CGFloat = 300
            
            let y = window.frame.height - height
            
            view.frame = window.frame
            view.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view.alpha = 1
                self.productDetailView.frame = CGRect(x: 0, y: y, width: self.productDetailView.frame.width, height: self.productDetailView.frame.height)
                
            }, completion: nil)
            
        }
    }
    
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.view.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                
                self.productDetailView.frame = CGRect(x: 0, y: window.frame.height, width: self.productDetailView.frame.width, height: self.productDetailView.frame.height)
            }
        }
    }
    
    
    private func fetchProduct(barCode: String){
        DBService.getProducts(productBarcode: barCode) { (error, product) in
            if let error = error {
                self.showAlert(title: "Error fetching product information", message: error.localizedDescription)
            } else {
                if let product = product {
                    self.products = product
                    dump(self.products)
                    
                    self.productDetailView.productName.text = product.name
                    self.productDetailView.productDetails.text = product.description
                    self.productDetailView.productPrice.text = "$" + String(product.price)
                    self.productDetailView.productImage.kf.setImage(with: URL(string: product.image))
                }
            }
        }
    }
        
        
    
    private func addToShoppingCart(){
        productDetailView.addToCartButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        
    }
    
    @objc private func addButtonPressed(){
        if let item = products {
            ItemsDataManager.addToShoppingCart(item: item)
            showAlert(title: "Success", message: "Successfully added item to shopping cart") { (alert) in
                self.navigationController?.present(ShoppingListViewController(), animated: true, completion: nil)
                print("Item added")
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
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height + 200)
        imageLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(imageLayer)
        session.startRunning()
    }
//
//
    




    
    

    
    
    
}

