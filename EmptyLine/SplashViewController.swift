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
    
    let animationView = AnimationView(name: "animation-w1920-h1080 (2)")

    override func viewDidLoad() {
        super.viewDidLoad()
    SplashScreen.addSubview(animationView)
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        animationView.frame = CGRect(x: -190, y: 100, width: 800, height: 800)
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
    //////////////////////////////////////////////
//        let gradient = CAGradientLayer()
//        var gradientSet = [[CGColor]]()
//        var currentGradient: Int = 0
//        let gradientOne = UIColor(red: 146/255, green: 175/255, blue: 255/255, alpha: 1).cgColor
//        let gradientTwo = UIColor(red: 245/255, green: 104/255, blue: 73/255, alpha: 1).cgColor
//        let gradientThree = UIColor(red: 216/255, green: 60/255, blue: 103/255, alpha: 1).cgColor
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view, typically from a nib.
//        }
//
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//
////            gradientSet.append([gradientOne, gradientTwo])
////            gradientSet.append([gradientTwo, gradientThree])
////            gradientSet.append([gradientThree, gradientOne])
////            gradientSet.append([gradientOne, gradientTwo])
////           gradientSet.append([gradientTwo, gradientOne])
//gradientSet.append([gradientThree, gradientTwo])
//gradientSet.append([gradientTwo, gradientOne])
//gradientSet.append([gradientOne, gradientTwo])
//            gradient.frame = self.view.bounds
//            gradient.colors = gradientSet[currentGradient]
//            gradient.startPoint = CGPoint(x:0, y:0)
//            gradient.endPoint = CGPoint(x:1, y:1)
//            gradient.drawsAsynchronously = true
//            self.view.layer.addSublayer(gradient)
//
//            animateGradient()
//             logoCon()
//        }
//
//        func animateGradient() {
//            if currentGradient < gradientSet.count - 1 {
//                currentGradient += 1
//            } else {
//                currentGradient = 0
//            }
//
//            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
//            gradientChangeAnimation.duration = 9.0
//            gradientChangeAnimation.toValue = gradientSet[currentGradient]
//            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards //CAMediaTimingFillMode.forwards
//            gradientChangeAnimation.isRemovedOnCompletion = false
//            gradient.add(gradientChangeAnimation, forKey: "colorChange")
//        }
//
//    lazy var zipLineLogo: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage.init(named: "logo")
//        image.contentMode = .scaleAspectFill
//        return image
//    }()
//
//    func logoCon(){
//        view.addSubview(zipLineLogo)
//        zipLineLogo.translatesAutoresizingMaskIntoConstraints = false
//        zipLineLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        zipLineLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        zipLineLogo.heightAnchor.constraint(equalToConstant: 298).isActive = true
//        zipLineLogo.widthAnchor.constraint(equalToConstant: 308).isActive = true
//    }
//
//    }
//
//    extension SplashViewController: CAAnimationDelegate {
//        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//            if flag {
//                gradient.colors = gradientSet[currentGradient]
//                animateGradient()
//            }
//
//        }
    //////////////////////////////////////
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       // yellow (253,197,119)
//       // red (198,52,133)
//
////        purple (171,126,253)
////        blue (146,175,255)
//       // pink (250,192,243) (252,211,247)
//
////        var colorOne = UIColor.init(displayP3Red: 253/255, green: 197/255, blue: 119/255, alpha: 1).cgColor //Orangeish
////        var colorTwo = UIColor.init(displayP3Red: 198/255, green: 52/255, blue: 133/255, alpha: 1).cgColor //Redish
//
////        var colorOne = UIColor.init(displayP3Red: 171/255, green: 126/255, blue: 253/255, alpha: 1).cgColor
//        let colorTwo = UIColor.init(displayP3Red: 146/255, green: 175/255, blue: 255/255, alpha: 1).cgColor
//        let colorThree = UIColor.init(displayP3Red: 252/255, green: 211/255, blue: 247/255, alpha: 1).cgColor
//
//        let gradient = CAGradientLayer()
//        gradient.frame = self.view.bounds
////        gradient.startPoint = CGPoint(x:0.0, y:0.5)
////        gradient.endPoint = CGPoint(x:1.0, y:0.5)
//        gradient.colors = [colorTwo,colorThree]
//
////            [UIColor.yellow.cgColor, UIColor.purple.cgColor]
////        gradient.locations =  [0.0, 0.25]
//        gradient.locations =  [-0.5, 1.5]
//
//        let animation = CABasicAnimation(keyPath: "colors")
//        animation.fromValue = [colorTwo,colorThree]
//        animation.toValue = [colorThree, colorTwo]
//        animation.duration = 5.0
//        animation.autoreverses = true
//        animation.repeatCount = Float.infinity
//
//        gradient.add(animation, forKey: nil)
//        self.view.layer.addSublayer(gradient)
//        logoCon()
//    }
    
    
//}
