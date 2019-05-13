//
//  WebSitewebView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WebSitewebView: UIWebView {
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        webConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func webConstraints(){
    }
}
