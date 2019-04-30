//
//  AppDelegate.swift
//  EmptyLine
//
//  Created by Pursuit on 4/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase
import Stripe

let prColor = UIColor(hue: 0.6361, saturation: 0.25, brightness: 0.51, alpha: 1.0)
let seColor = UIColor(hue: 199/360, saturation: 18/100, brightness: 100/100, alpha: 1.0)


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var authservice = AuthService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let _ = AppDelegate.authservice.getCurrentUser() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPageTabBarController = storyboard.instantiateViewController(withIdentifier: "MainPageTabBarController") as! UITabBarController
            window?.rootViewController = mainPageTabBarController
            
            window?.makeKeyAndVisible()
        
        } else {
            let storyboard = UIStoryboard(name: "login", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
        window?.makeKeyAndVisible()
        STPPaymentConfiguration.shared().publishableKey = "pk_test_i7MR3ZBZYlLBbv06qTLnTZit00egT6HNvb"
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

