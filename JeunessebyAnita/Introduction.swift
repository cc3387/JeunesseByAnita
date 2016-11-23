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

    @IBOutlet weak var AboutJ: UILabel!
    @IBOutlet weak var JProducts: UILabel!
    @IBOutlet weak var StartBrowsing: UILabel!
    
    //Language to Link
    var link = "en-US"
    
    
    @IBAction func Traditional(_ sender: Any) {
    language = "traditional"
    self.link = "zh-US"
    self.AboutJ.text = "關於婕斯"
    self.JProducts.text = "婕斯產品"
    self.StartBrowsing.text = "開始瀏覽"
    }
    
    
    @IBAction func Simplified(_ sender: Any) {
    language = "simplified"
    self.link = "zh-US"
    self.AboutJ.text = "关于婕斯"
    self.JProducts.text = "婕斯产品"
    self.StartBrowsing.text = "开始浏览"
    }
    
    @IBAction func English(_ sender: Any) {
    language = "english"
    self.link = "en-US"
    self.AboutJ.text = "About Jeunesse"
    self.JProducts.text = "Products Info"
    self.StartBrowsing.text = "Start Browsing"
    }
    
    
    @IBAction func aboutjeunesse(_ sender: Any) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/our-story"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    @IBAction func Packages(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/packages"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }

    }
    
    override func viewDidLoad() {
        
        if(language == "english"){
            self.link = "en-US"
            self.AboutJ.text = "About Jeunesse"
            self.JProducts.text = "Products Info"
            self.StartBrowsing.text = "Start Browsing"
        }
        else if(language == "traditional"){
            self.link = "zh-US"
            self.AboutJ.text = "關於婕斯"
            self.JProducts.text = "婕斯產品"
            self.StartBrowsing.text = "開始瀏覽"
        }
        else if(language == "simplified"){
            self.link = "zh-US"
            self.AboutJ.text = "关于婕斯"
            self.JProducts.text = "婕斯产品"
            self.StartBrowsing.text = "开始浏览"
        }
    }
    
    
};

//Language
var language = "english"



