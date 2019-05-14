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
    var qrcode = QRNBarCodeCodeViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCartAni.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationView.stop()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImage.frame.origin.y -= 10
        }) {_ in
            UIView.animate(withDuration: 0.3, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.arrowImage.frame.origin.y += 10
            })
        }
        settin()
        view.backgroundColor = UIColor(hexString: "BCBDC0")
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
//        dontAdd.isHidden = true
//        let animationView = AnimationView(name: "animation-w64-h64 (1)")
//        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        //animationView.contentMode = .scaleAspectFill
       // animationView.loopMode = .loop
        
       // animationView.realtimeAnimationProgress
        //self.dontAddCartAnimation.addSubview(animationView)
        //animationView.play()
        print("dont add me pressed")
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        animationView.play{(success:Bool) in
            
        }
        //////FIX THIS LATER
//        dragViewController.view.frame = CGRect(x: 0,
//                                               y: 900,
//                                               width: self.view.bounds.width,
//                                               height: dViewHeight)
        //      animationView.contentMode = .scaleAspectFill
        //        animationView.loopMode = .loop
        //       animationView.realtimeAnimationProgress
       // animationView.forceDisplayUpdate()
        //animationView.stop()
        //animationView.play()
//        //animationView.backgroundBehavior = .pauseAndRestore
        print("add me pressed")
//
    }

}
