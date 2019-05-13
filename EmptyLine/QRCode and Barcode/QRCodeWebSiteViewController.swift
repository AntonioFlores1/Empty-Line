//
//  QRCodeWebSiteViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import WebKit

class QRCodeWebSiteViewController: UIViewController,WKNavigationDelegate {
    var url = URL.init(string: "")
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let link = "https://www.cvs.com/"
        print(url)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        //webSite.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    

    

}
