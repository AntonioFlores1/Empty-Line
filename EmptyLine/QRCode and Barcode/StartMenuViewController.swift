//
//  StartMenuViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/24/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import ZKCarousel

class StartMenuViewController: UIViewController {
    
    @IBOutlet weak var displayView: ZKCarousel! = ZKCarousel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCarousel()
//        self.carousel.bounds = CGRect()
//        self.displayView.addSubview(carousel)
//        self.view.addSubview(self.carousel)
    }
    
    private func setupCarousel() {

        // Create as many slides as you'd like to show in the carousel
        let slide = ZKCarouselSlide(image: #imageLiteral(resourceName: "photo-1542838132-92c53300491e"), title: " ", description: "Scan items as you add them to your Cart")
        let slide1 = ZKCarouselSlide(image: #imageLiteral(resourceName: "photo-1521566652839-697aa473761a"), title: " ", description: "See your total and pay on your phone when you're ready")
        let slide2 = ZKCarouselSlide(image: #imageLiteral(resourceName: "photo-1540340061722-9293d5163008"), title: " ", description: "Show the receipt on your way out")
        let slide3 = ZKCarouselSlide(image: #imageLiteral(resourceName: "photo-1545186182-9faaf78480b8"), title: " Happy Shopping", description: " ")
//        let slide4 = ZKCarouselSlide(image: #imageLiteral(resourceName: "demo"), title: "A Demo Slide", description: "lorem ipsum devornum cora fusoa foen sdie ha odab ebakldf shjbesd ljkhf")
//        let slide5 = ZKCarouselSlide(image: #imageLiteral(resourceName: "demo2"), title: "Another Demo Slide", description: "lorem ipsum devornum cora fusoa foen ebakldf shjbesd ljkhf")

        // Add the slides to the carousel
        self.displayView.slides = [slide, slide1, slide2,slide3]
       //  slide3, slide4, slide5

        // You can optionally use the 'interval' property to set the timing for automatic slide changes. The default is 1 second.
        self.displayView.interval = 3.5

        // Optional - automatic switching between slides.
        self.displayView.start()
    }
    

}
