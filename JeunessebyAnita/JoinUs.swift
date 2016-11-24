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

class JoinUs:UIViewController{
    
    
    var ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var Back: UILabel!
    @IBOutlet weak var Joinustitle: UILabel!
    @IBOutlet weak var Joinfornineone: UILabel!
    @IBOutlet weak var Joinforninetwo: UILabel!
    @IBOutlet weak var JoinUsWords: UITextView!
    
    override func viewDidLoad() {
    
        if(language == "english"){
            language = "english"
            self.Back.text = "Back"
            self.Joinustitle.text = "Join Us"
            self.Joinfornineone.text = "Become an app user for $0.99/month"
            self.Joinforninetwo.text = "Buy Product, join for $0.99/month"
        }
        else if(language == "traditional"){
            language = "traditional"
            self.Back.text = "回到前頁"
            self.Joinustitle.text = "加入我們"
            self.Joinfornineone.text = "加入團隊，成為版主-每月0.99美元"
            self.Joinforninetwo.text = "購買婕斯,接收訊息-每月0.99美元"
        }
        else if(language == "simplified"){
            language = "simplified"
            self.Back.text = "回到前页"
            self.Joinustitle.text = "加入我们"
            self.Joinfornineone.text = "加入团队,成为版主-每月0.99美元"
            self.Joinforninetwo.text = "购买婕斯,接收讯息-每月0.99美元"
        }
        
   ///////////////////////////////////////////////////////////////////////////////////////////
        
        self.JoinUsWords.text = ""
        
        if(ProfileLogin.loginemail == "" && ProfileLogin.password == "" && ProfileLogin.uid == "" && ProfileLogin.phoneid == ""){
            
            //ref.queryOrdered(byChild: "Email").queryEqual(toValue: "luianita@yahoo.com")
            //    .observe(.childAdded, with: { snapshot in
            //        if let source = snapshot.value as? [String:AnyObject] {
            //            let Joinus = source["Joinus"] as! String
            //            self.JoinUsWords.text = Joinus
            //        }
            //})
        }
        else{
            
            ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
                .observe(.childAdded, with: { snapshot in
                    if let source = snapshot.value as? [String:AnyObject] {
                        let Joinus = source["Joinus"] as! String
                        print(Joinus)
                        self.JoinUsWords.text = Joinus
                    }
            })
            
        }
    }
};
