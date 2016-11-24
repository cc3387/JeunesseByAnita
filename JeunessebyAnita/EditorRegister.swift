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

class EditorRegister:UIViewController{
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Referral: UITextField!
    @IBOutlet weak var Warning: UILabel!
    
    var ref = FIRDatabase.database().reference()
    var upper = "" as String;
    var uid = "" as String;
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    //Back Button
    @IBAction func BackButton(_ sender: AnyObject) {
        
        if(ProfileLogin.loginemail == ""){
           loadfirstpage()
        }
        else if(ProfileLogin.loginemail != ""){
           loadmenu()
        }
    }
    
    
    //Register Action
    @IBAction func Register(_ sender: AnyObject) {
        
        Registergroup.loginemail = self.Email.text!
        Registergroup.password = self.Password.text!
        Registergroup.registername = self.Name.text!
        
        if(self.Email.text != "" && self.Password.text != "" && self.Name.text != "" && self.Referral.text != ""){
        FIRAuth.auth()!.createUser(withEmail: self.Email.text!, password: self.Password.text!) { (user, error) in
            
            if error != nil {
                // There was an error creating the account
                print("There was an error in creating")
            } else {
                let uid = user?.uid
                var phoneid = ""
                self.uid = uid!;
                
                
                if(BatchPush.lastKnownPushToken() != nil){
                    phoneid = BatchPush.lastKnownPushToken()
                }
                else{
                    phoneid = "";
                }
                
                print("Successfully created user account with uid: \(uid)")
                
                //Finding the upper management board
                var ref = FIRDatabase.database().reference()
                
                ref.queryOrdered(byChild: "Email").queryEqual(toValue: self.Referral.text!).observe(.childAdded, with: { snapshot in
                    if let source = snapshot.value as? [String:AnyObject] {
                        let refer = source["Refer"] as! String
                        let upperuid = source["uid"] as! String
                        self.upper = self.Referral.text!;
                        print("This is first: " + self.upper)
                        
                        //ref.queryOrdered(byChild: "Email").queryEqual(toValue: self.upper).observe(.childAdded, with: { snapshot in
                            //if let source = snapshot.value as? [String:AnyObject] {
                                //let referone = source["Refer"] as! String
                                //self.upper = referone;
                                //print("This is second: " + self.upper);
                                
                                
                                var profile = [
                                    "AboutLeader": "",
                                    "AboutLeadereng": "",
                                    "AccountType": "Write",
                                    "Email": self.Email.text!,
                                    "Joinlink": "",
                                    "Joinus":"",
                                    "Joinuseng":"",
                                    "Owner": self.Name.text!,
                                    "Phoneid" : phoneid,
                                    "Shoplink": "",
                                    "Foreword": "",
                                    "Forewordeng":"",
                                    "password": self.Password.text!,
                                    "uid": self.uid,
                                    "notification": "1",
                                    "Refer": self.Referral.text!,
                                    "Upper": self.upper,
                                    "Lower": ""
                                ];
                        
                                var lowerupload = [
                                    "Lower": Registergroup.loginemail
                                ];

                                ref.queryOrdered(byChild: "Email").queryEqual(toValue: self.Referral.text!).observe(.childAdded, with: { snapshot in
                                        if let source = snapshot.value as? [String:AnyObject] {
                                            let uid = source["uid"] as! String
                                            self.Referral.text = source["Refer"] as! String
                                            self.ref.child(byAppendingPath: uid).child("Lower").childByAutoId().setValue(lowerupload)
                                    }
                                })
                        
                                //Setting Value in database
                                self.ref.child(byAppendingPath: self.uid as String).setValue(profile)
                        //}
                    //})
                    }
                })

                var contactarr = [
                    "phoneid": phoneid,
                    "uid": self.uid
                ]
                
                //Sending info to databse
                var userref = self.ref.child("friends")
                
                //Setting contacts at Anita and referred contacts
                self.ref.child("dygW8oXUlSQ1OvZ1nEOZ6RJVAJR2").child("Contacts").child(self.uid + "_contact").setValue(contactarr)
                
                if(self.Referral.text! != "luianita@yahoo.com"){
                self.ref.queryOrdered(byChild: "Email").queryEqual(toValue: self.Referral.text!)
                    .observe(.childAdded, with: { snapshot in
                        
                        if let source = snapshot.value as? [String:AnyObject] {
                            
                            let uid = source["uid"] as! String
                            self.ref.child(uid).child("Contacts").child(self.uid + "_contact").setValue(contactarr)
                        }
                })
                }
                else if(self.Referral.text! == ""){
                //Do Nothing
                }
            }
        }
        
        loadoriginal()
        }
        else{
        self.Warning.textColor = UIColor.red
        }
    }
    
    
    func loadoriginal(){
        self.performSegue(withIdentifier: "topurchase", sender: nil)
    }
    
    func loadfirstpage(){
        self.performSegue(withIdentifier: "registeroriginal", sender: nil)
    }
    
    func loadmenu(){
        self.performSegue(withIdentifier: "registermenu", sender: nil)
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
};
