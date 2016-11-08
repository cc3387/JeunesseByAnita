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
    
    
    var ref = FIRDatabase.database().reference()
    @IBOutlet weak var AboutLeader: UITextView!
    
    override func viewDidLoad() {
        
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
