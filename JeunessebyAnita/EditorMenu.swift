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

class EditorMenu:UIViewController{
    
    override func viewDidLoad() {
    
        
        
        
        
        
        
    }
    
    @IBAction func Logout(_ sender: AnyObject) {
        //try! FIRAuth.auth()!.signOut()
        loadoriginal();
    }
    
    
    func loadoriginal(){
        self.performSegue(withIdentifier: "original", sender: nil)
    }
    
    
};
