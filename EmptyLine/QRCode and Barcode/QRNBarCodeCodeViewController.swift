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
import WebKit
import ZKCarousel

class QRNBarCodeCodeViewController:
UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var panGesture = UIPanGestureRecognizer()
    var webby = QRCodeWebSiteViewController()
    var barCodeRawValueLabel: UILabel!
    var tap = UITapGestureRecognizer()
    var bar = ""
    var website = ""
    let session = AVCaptureSession()
    lazy var vision = Vision.vision()
    var barcodeDetector :VisionBarcodeDetector?

    var idk = MyWebby()
    var productDetailView = ProductDetailsView()
    private var products:Item?
    
    enum DViewState {
        case expanded
        case collapsed
    }
    
    var dragViewController:DragViewController!
    var blurView:UIVisualEffectView!
    
    let dViewHeight:CGFloat = 500
    let dViewHandleAreaHeight:CGFloat = 190
    
    var DViewVisible = false
    var nextState:DViewState {
        return DViewVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrapted:CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = UINavigationBar.appearance()
        nav.backgroundColor = .blue
        startLiveVideo()
        addToShoppingCart()
//      antonioAddToShoppingCart()
        dontAddToShoppingCart()
        byebyeWebSite()
        fetchProduct(barCode: bar)
        self.barcodeDetector = vision.barcodeDetector()
        
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationController?.isNavigationBarHidden = true
//      setUpDragableView()
        
        blurView = UIVisualEffectView()
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        dragViewController = DragViewController(nibName:"DragViewController", bundle:nil)
        self.addChild(dragViewController)
        self.view.addSubview(dragViewController.view)
        dragViewController.view.frame = CGRect(x: 0,
                                               y: 900,
                                               width: self.view.bounds.width,
                                               height: dViewHeight)

        
        tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        productDetailView.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(tapViewDetail))
        self.view.isUserInteractionEnabled = true
        productDetailView.addGestureRecognizer(tap)
        self.dragViewController.view.layer.cornerRadius = 20
    }
    
    func setUpDragableView() {
        
        dragViewController.view.frame = CGRect(x: 0,
                                               y: self.view.frame.height - dViewHandleAreaHeight,
                                               width: self.view.bounds.width,
                                               height: dViewHeight)
        
        dragViewController.view.clipsToBounds = true
        
    dragViewController.addButtonToCart.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        dragViewController.dontAdd.addTarget(self, action: #selector(dontAddMe), for: .touchUpInside)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragableViewPanHandler(recognizer:)))
        dragViewController.dragArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func dragableViewPanHandler(recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
            
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            
            let translation = recognizer.translation(in: self.dragViewController.dragArea)
            var fractionComplete = translation.y / dViewHeight
            fractionComplete = DViewVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete )
            
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded(state:DViewState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                
                guard let self = self else { return }
                switch state {
                    
                case .expanded:
                    self.dragViewController.view.frame.origin.y = self.view.frame.height - self.dViewHeight
                    
                    
                case .collapsed:
                    self.dragViewController.view.frame.origin.y = self.view.frame.height - self.dViewHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { [weak self] _ in
                
                guard let self = self else { return }
                
                self.DViewVisible = !self.DViewVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
                
                guard let self = self else { return }
                
                switch state {
                    
                case .expanded:
                    self.dragViewController.view.layer.cornerRadius = 26
                case .collapsed:
                    self.dragViewController.view.layer.cornerRadius = 20
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let self = self else { return }
                switch state {
                    
                case .expanded:
                    self.blurView.effect = UIBlurEffect(style: .dark)
                    self.stopRecording()
                case .collapsed:
                    self.blurView.effect = nil
                    self.runningAnimations.removeAll()
                    self.session.startRunning()
                    
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:DViewState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrapted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrapted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    func stopRecording() {
        session.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopRecording()
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
                    if (barcodes?.first?.rawValue!.contains("https"))! || (barcodes?.first?.rawValue!.contains("http"))! {
                        self.website = (barcodes?.first?.rawValue)!
                        self.QRCodeSetView()
                        print("i is here \(self.website)")
                        
                        //self.urllink(url: self.website)
                    } else {
                        if (barcodes?.first?.rawValue!.count)! > 3 {
                            self.bar = (barcodes?.first?.rawValue)!
                            self.fetchProduct(barCode: self.bar)
                            self.setUpDragableView()
                            print("i is in second part \(self.bar)")
                        }
                    }
                }
            }
        }
    }
    
    func backGroundColor(){
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.magenta.cgColor,UIColor.red.cgColor,UIColor.purple.cgColor,UIColor.blue.cgColor]
        self.view.layer.addSublayer(gradient)
    }
    
    public func QRCodeSetView(){


        if let window = UIApplication.shared.keyWindow {
            view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(byebye)))
            window.addSubview(idk)
            let height: CGFloat = 400
            let y = window.frame.height - height
            view.frame = window.frame

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //self.view.alpha = 1
                self.idk.frame = CGRect(x: 0, y: y, width:
                    self.idk.frame.width, height:
                    self.idk.frame.height)
            }, completion: nil)
        }
    }
    
    
    private func byebyeWebSite(){
        idk.exit.addTarget(self, action: #selector(byebye), for: .touchUpInside)
    }
    
    @objc func byebye() {
        byeee()
    }
    
    @objc func byeee(){
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
            if let window = UIApplication.shared.keyWindow {
                self.idk.frame = CGRect(x: 0, y: window.frame.height, width: self.idk.frame.width, height: self.idk.frame.height)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    

    @objc func tapView() {
        productDetailView.center = CGPoint(x: productDetailView.center.x, y: self.view.center.y + 140)
    }
    @objc func tapViewDetail() {
        productDetailView.center = CGPoint(x: productDetailView.center.x, y: self.view.center.y + 140)
    }
    


    public func setupView(){
        if let window = UIApplication.shared.keyWindow {
            view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(productDetailView)
//            let height: CGFloat = 150

            let height: CGFloat = 150
            


            let y = window.frame.height - height
            view.frame = window.frame
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:  .transitionFlipFromBottom, animations: {            self.view.alpha = 1
                self.productDetailView.frame = CGRect(x: 0, y: y, width: self.productDetailView.frame.width, height: self.productDetailView.frame.height)
        },completion: nil)
    }
}


    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
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
                    self.dragViewController.itemName.text = product.name
                    self.dragViewController.itemDescription.text = product.description
                    self.dragViewController.itemPrice.text = "$" + String(product.price)
                    self.dragViewController.itemImage.kf.setImage(with: URL(string: product.image))
                }
            }
        }
    }
    
    private func addToShoppingCart(){
        productDetailView.addToCartButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc private func antonioAddToShoppingCart(){
        dragViewController.addButtonToCart.addTarget(self, action: #selector(antonioAddButtonPressed), for: .touchUpInside)
    }

//    private func antonioDontAddToShoppingCart(){
//        dragViewController.dontAdd .addTarget(self, action: #selector(dontAddMe), for: .touchUpInside)
//    }
    
    private func dontAddToShoppingCart(){
        productDetailView.deleteButton.addTarget(self, action: #selector(dontAddMe), for: .touchUpInside)
    }
    
    @objc func dontAddMe(){
        continueInteractiveTransition()
        self.blurView.effect = nil
        self.session.startRunning()
    dragViewController.view.frame = CGRect(x: 0,
                                               y: 900,
                                               width: self.view.bounds.width,
                                               height: dViewHeight)
    }

                        //Antonio Code Dont Touch//
//////////////////////////////////////////////////////////////////////////////////
    @objc private func antonioAddButtonPressed(){
//        dragViewController.view.frame = CGRect(x: 0,
//                                               y: 900,
//                                               width: self.view.bounds.width,
//                                               height: dViewHeight)
        let itemSavedDate = ItemSavedDate.init(createdDate: products?.boughtDate ?? "")
        savedDate.add(newDate: itemSavedDate)
        
        if let item = products {
            ShoppingCartDataManager.addItemToCart(shoppingItem: item)
            showAlert(title: "Success", message: "Item added to shopping cart")
            //            let alertController = UIAlertController(title: "Success", message: "Successfully added item to shopping cart", preferredStyle: .alert)
            //
            //            let continueShopping = UIAlertAction(title: "Continue Shopping", style: .cancel, handler: { (alert) in
            //                self.dismiss(animated: true, completion: nil)
            //            })
            //
            //            let checkOut = UIAlertAction(title: "Check Out", style: .default, handler: { (alert) in
            //                self.navigationController?.pushViewController(ShoppingListViewController(), animated: true)
            //            })
            //
            //            alertController.addAction(checkOut)
            //            alertController.addAction(continueShopping)
            //            self.present(alertController, animated: true)
            self.handleDismiss()
            print("Item added")
        }
    }
    
//////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc private func addButtonPressed(){
        dragViewController.view.frame = CGRect(x: 0,
                                               y: 900,
                                               width: self.view.bounds.width,
                                               height: dViewHeight)
        continueInteractiveTransition()
       self.blurView.effect = nil
        self.session.startRunning()
        let itemSavedDate = ItemSavedDate.init(createdDate: products?.boughtDate ?? "")
        savedDate.add(newDate: itemSavedDate)
        if let item = products {
            ShoppingCartDataManager.addItemToCart(shoppingItem: item)
            showAlert(title: "Success", message: "Item added to shopping cart")
//            let alertController = UIAlertController(title: "Success", message: "Successfully added item to shopping cart", preferredStyle: .alert)
//
//            let continueShopping = UIAlertAction(title: "Continue Shopping", style: .cancel, handler: { (alert) in
//                self.dismiss(animated: true, completion: nil)
//            })
//
//            let checkOut = UIAlertAction(title: "Check Out", style: .default, handler: { (alert) in
//                self.navigationController?.pushViewController(ShoppingListViewController(), animated: true)
//            })
//
//            alertController.addAction(checkOut)
//            alertController.addAction(continueShopping)
//            self.present(alertController, animated: true)
            self.handleDismiss()
            print("Item added")
        }
    }
    

     func startLiveVideo() {
        session.sessionPreset = AVCaptureSession.Preset.photo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        session.addInput(deviceInput)
        session.addOutput(deviceOutput)
        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height + 250)
        imageLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(imageLayer)
        session.startRunning()
    }
}


