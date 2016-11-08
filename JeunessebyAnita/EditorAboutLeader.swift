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

class EditorAboutLeader:UIViewController{
    
    var ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var EditAboutLeader: UITextView!
    
    override func viewDidLoad() {
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
            .observe(.childAdded, with: { snapshot in
                
                if let source = snapshot.value as? [String:AnyObject] {
                    
                    let AboutLeader = source["AboutLeader"] as! String
                    self.EditAboutLeader.text = AboutLeader
                
                }
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func Upload(_ sender: AnyObject) {
        
        let uploadstring = self.EditAboutLeader.text!
        ref.child(ProfileLogin.uid).child("AboutLeader").setValue(uploadstring)
        
        loadoriginal()
        
        
    }
    
    func loadoriginal(){
        self.performSegue(withIdentifier: "originalaboutleader", sender: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
};
