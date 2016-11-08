//
//  EditorForeword.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/22/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Foundation
import Batch
import Firebase

class EditorForeword:UIViewController{
    
    
    @IBOutlet weak var Forewords: UITextView!
    
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail)
            .observe(.childAdded, with: { snapshot in
                
                if let source = snapshot.value as? [String:AnyObject] {
                    
                    let Forewords = source["Foreword"] as! String
                    self.Forewords.text = Forewords
                    
                }
            })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func Upload(_ sender: AnyObject) {
        
        let uploadstring = self.Forewords.text!
        ref.child(ProfileLogin.uid).child("Foreword").setValue(uploadstring)
        
        loadDestinationVC()
    }
    
    //load destination after sent
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "forewordtomenu", sender: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
};
