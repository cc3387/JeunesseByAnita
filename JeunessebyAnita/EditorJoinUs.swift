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

class EditorJoinUs:UIViewController{
    
    @IBOutlet weak var JoinUsWords: UITextView!
    
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
    
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
            .observe(.childAdded, with: { snapshot in
                
                if let source = snapshot.value as? [String:AnyObject] {
                   
                   let Joinus = source["Joinus"] as! String
                   self.JoinUsWords.text = Joinus
                    
                }
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func Upload(_ sender: AnyObject) {
        
        let uploadstring = self.JoinUsWords.text!
        ref.child(ProfileLogin.uid).child("Joinus").setValue(uploadstring)
        
        loadDestinationVC()
    }
    
    //load destination after sent
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "backtoeditormenu", sender: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
};
