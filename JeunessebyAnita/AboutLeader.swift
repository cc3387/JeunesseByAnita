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

class AboutLeader:UIViewController{
    
    @IBOutlet weak var Back: UILabel!
    @IBOutlet weak var Leadership: UILabel!
    @IBOutlet weak var Joinusnineone: UILabel!
    @IBOutlet weak var Joinusninetwo: UILabel!
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    var ref = FIRDatabase.database().reference()
    @IBOutlet weak var AboutLeader: UITextView!
    
    override func viewDidLoad() {
        
        if(language == "english"){
            language = "english"
            self.Back.text = "Back"
            self.Leadership.text = "Leadership"
            self.Joinusnineone.text = "Become an app user for $0.99/month"
            self.Joinusninetwo.text = "Buy Product, join for $0.99/month"
        }
        else if(language == "traditional"){
            language = "traditional"
            self.Back.text = "回到前頁"
            self.Leadership.text = "關於領袖"
            self.Joinusnineone.text = "加入團隊，成為版主-每月0.99美元"
            self.Joinusninetwo.text = "購買婕斯,接收訊息-每月0.99美元"
        }
        else if(language == "simplified"){
            language = "simplified"
            self.Back.text = "回到前页"
            self.Leadership.text = "关于领袖"
            self.Joinusnineone.text = "加入团队,成为版主-每月0.99美元"
            self.Joinusninetwo.text = "购买婕斯,接收讯息-每月0.99美元"
        }
        
        self.AboutLeader.text = ""
        
        if(ProfileLogin.loginemail == "" && ProfileLogin.password == "" && ProfileLogin.uid == "" && ProfileLogin.phoneid == ""){
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: "luianita@yahoo.com")
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        let AboutLeader = source["AboutLeader"] as! String
                        self.AboutLeader.text = AboutLeader
                    }
            })
            
        }
        else{
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
                .observe(.childAdded, with: { snapshot in
                    
                    if let source = snapshot.value as? [String:AnyObject] {
                        let AboutLeader = source["AboutLeader"] as! String
                        self.AboutLeader.text = AboutLeader
                    }
            })
            
        }
    }
    
};
