//
//  ViewController.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/4/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch
import Firebase

class GetRich:UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var GetRichTextView: UITextView!
    @IBOutlet weak var myScrollView: UIScrollView!
    var myUIImageView: UIImageView!
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        
        self.myScrollView.maximumZoomScale = 5.0
        self.myScrollView.minimumZoomScale = 0.0
        self.myScrollView.delegate = self
        
        let image: UIImage = UIImage(named: "Jeunesse System.png")!
        
        myUIImageView = UIImageView(image: image)
        self.myScrollView.addSubview(myUIImageView)
        updateMinZoomScaleForSize(view.bounds.size)
        
        
        
        
        if(ProfileLogin.loginemail == "" && ProfileLogin.password == "" && ProfileLogin.uid == "" && ProfileLogin.phoneid == ""){
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: "luianita@yahoo.com")
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        
                        ProfileLogin.joinlink = source["Joinlink"] as! String
                        ProfileLogin.shoplink = source["Shoplink"] as! String
                        
                        self.GetRichTextView.text! = "1+4 成功方程式: " + "\n" + "1. 加入我们：" + "\n" + ProfileLogin.joinlink + "\n" + "2. 全面体验产品，跟贴系统带伙伴参加四个重要训练：艾莫总裁训练班 婕斯大学 创业新典范年会" + "\n" + ProfileLogin.shoplink + "/calendar"
                        
                    }
                })
        }
        else{
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        
                        ProfileLogin.joinlink = source["Joinlink"] as! String
                        ProfileLogin.shoplink = source["Shoplink"] as! String
                        
                        self.GetRichTextView.text! = "1+4 成功方程式: " + "\n" + "1. 加入我们：" + "\n" + ProfileLogin.joinlink + "\n" + "2. 全面体验产品，跟贴系统带伙伴参加四个重要训练：艾莫总裁训练班 婕斯大学 创业新典范年会" + "\n" + ProfileLogin.shoplink + "/calendar"
                        
                    }
            })
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myUIImageView
        
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / myUIImageView.bounds.width
        let heightScale = size.height / myUIImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        self.myScrollView.minimumZoomScale = minScale
        
        self.myScrollView.zoomScale = minScale
    }
}
