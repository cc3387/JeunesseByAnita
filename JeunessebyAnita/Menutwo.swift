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

class Menutwo:UIViewController{
    
    @IBAction func Trip(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US/lifestyle-rewards") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Buy(_ sender: AnyObject) {
        
        if(ProfileLogin.loginemail == ""){
            if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US") {
                UIApplication.shared.openURL(url as URL)
            }
        }
        else{
            
            var ref = FIRDatabase.database().reference()
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        ProfileLogin.shoplink = source["Shoplink"] as! String
                        
                        if(ProfileLogin.shoplink == ""){
                            if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US") {
                                UIApplication.shared.openURL(url as URL)
                            }
                        }
                        else{
                            if let url = NSURL(string: ProfileLogin.shoplink) {
                                UIApplication.shared.openURL(url as URL)
                            }
                        }
                            
                    }
            })
        }
    }
    
    override func viewDidLoad() {
    
    
    }
    
    
};
