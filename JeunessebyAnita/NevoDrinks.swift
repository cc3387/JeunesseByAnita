//
//  NevoDrinks.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 6/3/17.
//  Copyright © 2017 Clement Chan. All rights reserved.
//

import Foundation
import UIKit

class Nevo:UIViewController{
    
    
    //Language Link based on choices
    var link = "en-US"
    
    
    @IBAction func Website(_ sender: Any) {
        if(ProfileLogin.shop == ""){
            ProfileLogin.shop = "simplyeffective"
        }
        
        let product = "https://"+ProfileLogin.shop+".jeunesseglobal.com/"+self.link+"/nevo"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func viewDidLoad() {
        
        if(language == "english"){
            self.link = "en-US"
        }
        else if(language == "traditional"){
            self.link = "zh-US"
        }
        else if(language == "simplified"){
            self.link = "zh-US"
        }
        
    }
    
    
};
