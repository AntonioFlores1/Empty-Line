//
//  SplashViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 5/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var SplashScreen: LottieView!
    
    let animationView = AnimationView(name: "animation-w1080-h1080 (1)")

    override func viewDidLoad() {
        super.viewDidLoad()
    SplashScreen.addSubview(animationView)
        animationView.frame = CGRect(x: -190, y: 100, width: 800, height: 800)
        //animationView.loopMode = .loop
        animationView.play { (succes:Bool) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageTabBarController = storyboard.instantiateViewController(withIdentifier: "MainPageTabBarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.afterSplashScreenAnimation()
            print("thing")
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        //animationView.play()
    }

    
}
