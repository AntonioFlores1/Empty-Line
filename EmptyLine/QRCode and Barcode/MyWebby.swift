//
//  MyWebby.swift
//  EmptyLine
//
//  Created by Pursuit on 4/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import WebKit

class MyWebby: UIView, WKNavigationDelegate {

    var webView: WKWebView!

    //var linky: String!
    
    lazy var exit: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("X", for: .normal )
        return button
        }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .yellow
        webView = WKWebView()
        webView.navigationDelegate = self
        
        let link = "https://qrco.de/bb8tP8"
        let request = URLRequest(url: URL(string: link)!)
            webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        con()
    }
//    func urllink(url:String){
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        
//        let link = "http://l.ead.me/bb7Wej"
//        let request = URLRequest(url: URL(string: "http://l.ead.me/bb7Wej)!)
//        webView.load(request)
//        webView.allowsBackForwardNavigationGestures = true
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func con(){
        addSubview(webView)
        addSubview(exit)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        exit.translatesAutoresizingMaskIntoConstraints = false
        exit.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        exit.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        exit.topAnchor.constraint(equalTo: webView.topAnchor, constant: 0).isActive = true
        
    }
}
