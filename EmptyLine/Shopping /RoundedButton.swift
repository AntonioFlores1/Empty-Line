//
//  RoundedButton.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/29/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    var highlightedColor = UIColor.black
    var defaultColor = UIColor.black
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedColor
                
            } else {
                backgroundColor = defaultColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
