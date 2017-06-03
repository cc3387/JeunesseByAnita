//
//  ProductNew.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 6/2/17.
//  Copyright © 2017 Clement Chan. All rights reserved.
//

import Foundation
import Batch

class NewProduct:UIViewController{
    
    
    //Language Link based on choices
    var link = "en-US"
    @IBOutlet weak var Back: UILabel!
    @IBOutlet weak var MoreProductInfo: UILabel!
    @IBOutlet weak var NewProductLabel: UILabel!
    @IBOutlet weak var Producttitle: UILabel!
    
    @IBAction func Traditional(_ sender: Any) {
        language = "traditional"
        self.link = "zh-US"
        self.MoreProductInfo.text = "更多產品資訊"
        self.NewProductLabel.text = "2017 最新產品"
        
    }
    
    @IBAction func English(_ sender: Any) {
        language = "english"
        self.link = "en-US"
        self.MoreProductInfo.text = "More Product Info"
        self.NewProductLabel.text = "2017 New Product"
    }

    @IBAction func Simplified(_ sender: Any) {
        language = "simplified"
        self.link = "zh-US"
        self.MoreProductInfo.text = "更多产品资讯"
        self.NewProductLabel.text = "2017 最新产品"
    
    }
    
    override func viewDidLoad() {
        
        if(language == "english"){
            self.link = "en-US"
            self.MoreProductInfo.text = "More Product Info"
            self.NewProductLabel.text = "2017 New Product"
        }
        else if(language == "traditional"){
            self.link = "zh-US"
            self.MoreProductInfo.text = "更多產品資訊"
            self.NewProductLabel.text = "2017 最新產品"
        }
        else if(language == "simplified"){
            self.link = "zh-US"
            self.MoreProductInfo.text = "更多产品资讯"
            self.NewProductLabel.text = "2017 最新产品"
        }
        
    }
    
    
};
