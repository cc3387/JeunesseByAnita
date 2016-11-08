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

class GetRich:UIViewController{
    
    @IBOutlet weak var GetRichTextView: UITextView!
    
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
    
        if(ProfileLogin.loginemail == "" && ProfileLogin.password == "" && ProfileLogin.uid == "" && ProfileLogin.phoneid == ""){
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: "luianita@yahoo.com")
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        
                        ProfileLogin.joinlink = source["Joinlink"] as! String
                        ProfileLogin.shoplink = source["Shoplink"] as! String
                        
                        self.GetRichTextView.text! = "1+4 成功方程式: " + "\n" + "1. 加入我们：" + "\n" + ProfileLogin.joinlink + "\n" + "2. 参加四个重要训练：艾莫总裁训练班 婕斯大学 创业新典范年会" + "\n" + ProfileLogin.shoplink + "/calendar"
                        
                    }
                })
        }
        else{
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        
                        ProfileLogin.joinlink = source["Joinlink"] as! String
                        ProfileLogin.shoplink = source["Shoplink"] as! String
                        
                        self.GetRichTextView.text! = "1+4 成功方程式: " + "\n" + "1. 加入我们：" + "\n" + ProfileLogin.joinlink + "\n" + "2. 参加四个重要训练：艾莫总裁训练班 婕斯大学 创业新典范年会" + "\n" + ProfileLogin.shoplink + "/calendar"
                        
                    }
            })
        }
    }
}
