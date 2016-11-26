//
//  EditorNameShop.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/12/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch
import Firebase

class NameShop:UIViewController{
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Shop: UITextField!
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func Upload(_ sender: AnyObject) {
        ProfileLogin.name = self.Name.text!
        ref.child(ProfileLogin.uid).child("Joinlink").setValue("https://joffice.jeunesseglobal.com/signup.asp?locale=zh-US&siteurl=" + self.Shop.text!)
        ref.child(ProfileLogin.uid).child("Shoplink").setValue("https://" + self.Shop.text!+".jeunesseglobal.com/zh-US")
        loadoriginal()
    }
    
    
    func loadoriginal(){
        self.performSegue(withIdentifier: "Nametomenu", sender: nil)
    }
    
    
};
