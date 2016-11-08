//
//  ProductPage.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 11/6/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch

class ProductPage:UIViewController{
    
    @IBAction func MoneND(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/m1nd") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func ZEN(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/zen/project") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func FINITI(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/finiti") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Reserve(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/reserve") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func AMPM(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/am/pmessentials") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Luminecense(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/luminesce") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    @IBAction func InstantAgeless(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/instantly-ageless") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    override func viewDidLoad() {
        
    }
    
    
};
