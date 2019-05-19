//
//  DragViewController.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/25/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Lottie

class DragViewController: UIViewController {
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var dragArea: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var dontAddCartAnimation: LottieView!
    @IBOutlet weak var addCartAni: LottieView!
    @IBOutlet weak var dontAdd: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var itemDescription: UITextView!
    let animationView = AnimationView(name: "addToCartAni")
    let trashAnimation = AnimationView(name: "trashAnimation")
    var qrcode = QRNBarCodeCodeViewController()
 //   var drag = DragViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //labelCon()
        addCartAni.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationView.stop()
        
        dontAddCartAnimation.addSubview(trashAnimation)
        trashAnimation.frame = CGRect(x: -10, y: -15, width: 110, height: 110)
        trashAnimation.stop()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImage.frame.origin.y -= 10
        }) {_ in
            UIView.animate(withDuration: 0.3, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.arrowImage.frame.origin.y += 10
            })
        }
        settin()
        view.backgroundColor = .white
        //dontAdd.backgroundColor =  .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        settin()
    }
    
    private func settin() {
        if qrcode.dViewHeight == 500 {
//            self.arrowImage.isHidden = true
        }
    }
    // new
//    override func viewWillAppear(_ animated: Bool) {
////        setArrowAnimation()
//        UIView.animate(withDuration: 0.3, animations: {
//            self.arrowImage.frame.origin.y -= 10
//        }) {_ in
//            UIView.animate(withDuration: 0.3, delay: 0.25, options: [.autoreverse, .repeat], animations: {
//                self.arrowImage.frame.origin.y += 10
//            })
//        }
//    }
//
//    private func setArrowAnimation() {
//        if qrcodeandbarcode.dViewHeight == 500 {
//            if arrowImage.image == UIImage(named: "arrow-up") {
//                UIView.transition(with: arrowImage, duration: 1.0, options: [.transitionFlipFromRight], animations: {
//                    self.arrowImage.image = UIImage(named: "down-arrow")
//                    print("Image changed")
//                })
//                }
//            } else {
//            UIView.transition(with: arrowImage, duration: 1.0, options: [.transitionFlipFromRight], animations: {
//                self.arrowImage.image = UIImage(named: "arrow-up")
//            })
//
//            }
////        if qrcodeandbarcode.dViewHeight == 500{
////            if arrowImage.image == UIImage(named: "arrow-up") {
////                UIView.transition(with: arrowImage, duration: 1.0, options: [.transitionFlipFromRight], animations: {
////                    self.arrowImage.image = UIImage(named: "down-arrow")
////                    print("Image changed")
////                })
////            } else {
////                UIView.transition(with: arrowImage, duration: 1.0, options: [.transitionFlipFromRight], animations: {
////                    self.arrowImage.image = UIImage(named: "arrow-up")
////                })
////            }
////        }
//    }
    @objc func thingstodo(){
        print("i is pressed")
    }
    
    @objc func thingido(){
        print("i fucking work")
    }
    @IBAction func dontAddButton(_ sender: Any) {
        trashAnimation.play{(success:Bool) in
            self.trashAnimation.forceDisplayUpdate()
            self.trashAnimation.stop()
            self.view.frame = CGRect(x: 0, y: 900, width: self.view.bounds.width, height: 900)
            }
        self.trashAnimation.forceDisplayUpdate()

        print("dont add me pressed")
    }
    
    
    @IBAction func addToCartButton(_ sender: Any) {
        animationView.play{(success:Bool) in
            print("after ani")
            self.animationView.forceDisplayUpdate()
            self.animationView.stop()
             self.view.frame = CGRect(x: 0, y: 900, width: self.view.bounds.width, height: 900)
        }
       
        //////FIX THIS LATER
        
//        dragViewController.view.frame = CGRect(x: 0,
//                                               y: 900,
//                                               width: self.view.bounds.width,
//                                               height: dViewHeight)
        //      animationView.contentMode = .scaleAspectFill
        //        animationView.loopMode = .loop
        //       animationView.realtimeAnimationProgress
        animationView.forceDisplayUpdate()
       // animationView.stop()
        //animationView.play()
//        //animationView.backgroundBehavior = .pauseAndRestore
        print("add me pressed")
//
    }
    
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textColor = .red
        return label
    }()
    
    lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Add"
        label.textColor = .green
        return label
    }()
    
    func labelCon(){
    view.addSubview(cancelLabel)
    view.addSubview(addLabel)
    cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelLabel.topAnchor.constraint(equalTo: dontAdd.bottomAnchor, constant: 5).isActive = true
       // cancelLabel.centerYAnchor.constraint(equalTo: dontAdd.centerYAnchor).isActive = true
        cancelLabel.centerXAnchor.constraint(equalTo: dontAdd.centerXAnchor, constant: 0).isActive = true
        
    addLabel.translatesAutoresizingMaskIntoConstraints = false
        addLabel.topAnchor.constraint(equalTo: addCartAni.bottomAnchor).isActive = true
        addLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10).isActive = true
        addLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        addLabel.centerXAnchor.constraint(equalTo: addButton.centerXAnchor, constant: 0).isActive = true
        
    }

}
