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
    
    @IBOutlet weak var Producttitle: UILabel!
    @IBOutlet weak var Skincare: UILabel!
    @IBOutlet weak var Healthcare: UILabel!
    @IBOutlet weak var Ageless: UILabel!
    @IBOutlet weak var Lumincense: UILabel!
    @IBOutlet weak var AMPM: UILabel!
    @IBOutlet weak var Reserve: UILabel!
    @IBOutlet weak var Finiti: UILabel!
    @IBOutlet weak var ZenProject: UILabel!
    @IBOutlet weak var MoneND: UILabel!
    
    
    //Language Link based on choices
    var link = "en-US"
    
    
    @IBAction func Traditional(_ sender: Any) {
        language = "traditional"
        self.link = "zh-US"
        self.Producttitle.text = "產品介紹"
        self.Producttitle.adjustsFontSizeToFitWidth = true
        self.Skincare.text = "護膚保養"
        self.Healthcare.text = "營養保健"
        self.Ageless.text = "瞬效眼膠"
        self.Lumincense.text = "LUMINESCE™活肌因系列"
        self.AMPM.text = "AMPM Essentials™"
        self.Reserve.text = "RESERVE™ 沛泉菁華"
        self.Finiti.text = "FINITI®飛樂青春膠囊"
        self.ZenProject.text = "ZEN Project 8™"
        self.MoneND.text = "M1ND-特別添加CERA-Q™"
    }
    
    @IBAction func English(_ sender: Any) {
        language = "english"
        self.link = "en-US"
        self.Producttitle.text = "Products"
        self.Producttitle.adjustsFontSizeToFitWidth = true
        self.Skincare.text = "Skin Care Products"
        self.Healthcare.text = "Health Care Products"
        self.Ageless.text = "Instant Ageless™"
        self.Lumincense.text = "LUMINESCE™"
        self.AMPM.text = "AMPM Essentials™"
        self.Reserve.text = "RESERVE™"
        self.Finiti.text = "FINITI®"
        self.ZenProject.text = "ZEN Project 8™"
        self.MoneND.text = "M1ND"
    }
    
    @IBAction func Simplified(_ sender: Any) {
        language = "simplified"
        self.link = "zh-US"
        self.Producttitle.text = "产品介绍"
        self.Producttitle.adjustsFontSizeToFitWidth = true
        self.Skincare.text = "护肤保养"
        self.Healthcare.text = "营养保健"
        self.Ageless.text = "瞬效眼胶"
        self.Lumincense.text = "LUMINESCE™活肌因系列"
        self.AMPM.text = "AMPM Essentials™"
        self.Reserve.text = "RESERVE™ 沛泉菁华"
        self.Finiti.text = "FINITI®飞乐青春胶囊"
        self.ZenProject.text = "ZEN Project 8™"
        self.MoneND.text = "M1ND-特別添加CERA-Q™"
    }
    
    
    @IBAction func MoneND(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/m1nd"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func ZEN(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/zen/project"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func FINITI(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/finiti"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Reserve(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/reserve"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func AMPM(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/am/pmessentials"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Luminecense(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/luminesce"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    @IBAction func InstantAgeless(_ sender: AnyObject) {
        
        let product = "https://simplyeffective.jeunesseglobal.com/"+self.link+"/instantly-ageless"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func viewDidLoad() {
        
        if(language == "english"){
            self.link = "en-US"
            self.Producttitle.text = "Products"
            self.Producttitle.adjustsFontSizeToFitWidth = true
            self.Skincare.text = "Skin Care Products"
            self.Healthcare.text = "Health Care Products"
            self.Ageless.text = "Instant Ageless™"
            self.Lumincense.text = "LUMINESCE™"
            self.AMPM.text = "AMPM Essentials™"
            self.Reserve.text = "RESERVE™"
            self.Finiti.text = "FINITI®"
            self.ZenProject.text = "ZEN Project 8™"
            self.MoneND.text = "M1ND"
        }
        else if(language == "traditional"){
            self.link = "zh-US"
            self.Producttitle.text = "產品介紹"
            self.Producttitle.adjustsFontSizeToFitWidth = true
            self.Skincare.text = "護膚保養"
            self.Healthcare.text = "營養保健"
            self.Ageless.text = "瞬效眼膠"
            self.Lumincense.text = "LUMINESCE™活肌因系列"
            self.AMPM.text = "AMPM Essentials™"
            self.Reserve.text = "RESERVE™ 沛泉菁華"
            self.Finiti.text = "FINITI®飛樂青春膠囊"
            self.ZenProject.text = "ZEN Project 8™"
            self.MoneND.text = "M1ND-特別添加CERA-Q™"
        }
        else if(language == "simplified"){
            self.link = "zh-US"
            self.Producttitle.text = "产品介绍"
            self.Producttitle.adjustsFontSizeToFitWidth = true
            self.Skincare.text = "护肤保养"
            self.Healthcare.text = "营养保健"
            self.Ageless.text = "瞬效眼胶"
            self.Lumincense.text = "LUMINESCE™活肌因系列"
            self.AMPM.text = "AMPM Essentials™"
            self.Reserve.text = "RESERVE™ 沛泉菁华"
            self.Finiti.text = "FINITI®飞乐青春胶囊"
            self.ZenProject.text = "ZEN Project 8™"
            self.MoneND.text = "M1ND-特別添加CERA-Q™"
        }
        
    }
    
    
};
