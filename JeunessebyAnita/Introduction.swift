//
//  Introduction.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 11/6/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch

class Intro:UIViewController{
    
    @IBAction func aboutjeunesse(_ sender: AnyObject) {
    if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/our-story") {
    UIApplication.shared.openURL(url as URL)
    }
    }
    
    
    @IBAction func Packages(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/packages") {
            UIApplication.shared.openURL(url as URL)
        }

    }
    
    override func viewDidLoad() {
        
    }
    
    
};
