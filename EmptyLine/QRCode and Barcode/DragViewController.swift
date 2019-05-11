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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCartAni.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationView.stop()
        
    }
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
