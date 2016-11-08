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
    
    @IBOutlet weak var JoinUsWords: UITextView!
    
    override func viewDidLoad() {
        
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
