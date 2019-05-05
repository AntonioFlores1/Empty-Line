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
    
    @IBOutlet weak var addToCartAnimation: LottieView!
    
    @IBOutlet weak var dontAddCartAnimation: LottieView!
    
    
    @IBOutlet weak var addButtonToCart: UIButton!
    
    @IBOutlet weak var dontAdd: UIButton!
    
    @IBOutlet weak var itemDescription: UITextView!
    
    let things = AnimatedButton()
//things.translatesAutoresizingMaskIntoConstraints = false
    /// Set an animation on the button.
//    things.animation = Animation.named("TwitterHeartButton", subdirectory: "TestAnimations")
    /// Turn off clips to bounds, as the animation goes outside of the bounds.
//    things.clipsToBounds = false
    /// Set animation play ranges for touch states
//    twitterButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
//    twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
//    twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
//    view.addSubview(twitterButton)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addButton.animation = Animation.named("animation-w800-h600")
        constraints()
        things.backgroundColor = .red
        things.animation = Animation.named("animation-w800-h600")
        things.clipsToBounds = false
        things.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
       // view.addSubview(things)
    }

    
    @IBAction func dontAddButton(_ sender: Any) {
//        dontAdd.isHidden = true
        let animationView = AnimationView(name: "animation-w64-h64 (1)")
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        //animationView.contentMode = .scaleAspectFill
       // animationView.loopMode = .loop
       // animationView.realtimeAnimationProgress
        //self.dontAddCartAnimation.addSubview(animationView)
        //animationView.play()
        print("dont add me pressed")
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
//        addButton.isHidden = true
        
        // let animationView = AnimationView(name: "animation-w800-h600")
    //animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
      //      animationView.contentMode = .scaleAspectFill
//        animationView.loopMode = .loop
//        animationView.realtimeAnimationProgress
 //self.addToCartAnimation.addSubview(animationView)
       // animationView.forceDisplayUpdate()
        
      //  animationView.play()
        //animationView.backgroundBehavior = .pauseAndRestore
        print("add me pressed")
        
    }
    
    func constraints(){
        view.addSubview(things)
        things.translatesAutoresizingMaskIntoConstraints = false
        things.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        things.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        things.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 80).isActive = true
        things.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        things.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
//        things.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 80).isActive = true
    }

}
