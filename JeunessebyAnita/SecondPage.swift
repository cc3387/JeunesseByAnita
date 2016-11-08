//
//  SecondPage.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/22/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SecondPage:UIViewController{
    
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail).observe(.childAdded, with: { snapshot in
            if let source = snapshot.value as? [String:AnyObject] {
                let foreword = source["Foreword"] as! String
                ProfileLogin.foreword = foreword
            }
        })
        
        self.view.backgroundColor = UIColor(red: 240, green: 230, blue: 255)
        
        //Load next page
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.loadDestinationVC()
        };
    }
    
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "toboard", sender: nil)
    }
    
    
};
