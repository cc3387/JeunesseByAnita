//
//  YourFuture.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 11/15/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import UIKit

class YourFuture: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var myUIScrollView: UIScrollView!
    var myUIImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myUIScrollView.maximumZoomScale = 5.0
        self.myUIScrollView.minimumZoomScale = 0.0
        self.myUIScrollView.delegate = self
        
        let image: UIImage = UIImage(named: "Jeuness_Ranking.jpg")!
        
        myUIImageView = UIImageView(image: image)
        self.myUIScrollView.addSubview(myUIImageView)
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myUIImageView
        
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / myUIImageView.bounds.width
        let heightScale = size.height / myUIImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        self.myUIScrollView.minimumZoomScale = minScale
        
        self.myUIScrollView.zoomScale = minScale
    }
}
