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

class Login:UIViewController{
    
    
    @IBOutlet weak var LoginPage: UILabel!
    @IBOutlet weak var EmailTitle: UILabel!
    @IBOutlet weak var PasswordTitle: UILabel!
    @IBOutlet weak var LoginButtonTitle: UILabel!
    @IBOutlet weak var Back: UILabel!
    var link = ""
    
    
    /////////////////////////////////////////////////
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Exception: UILabel!
    
    //Account Type of Login process
    var accounttype = "";
    var ref = FIRDatabase.database().reference()
    
    @IBAction func loadprevious(_ sender: AnyObject) {
    
        if(ProfileLogin.loginemail == ""){
        loadfirstpage()
        }
        else if(ProfileLogin.loginemail != ""){
        loadmenu()
        }
    }
    
    
    @IBAction func Login(_ sender: AnyObject) {
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: self.Email.text!)
            .observe(.childAdded, with: { snapshot in
                
                if let source = snapshot.value as? [String:AnyObject] {
                    
                    let AccountType = source["AccountType"] as! String
                    self.accounttype = AccountType
                    ProfileLogin.name = source["Owner"] as! String
                    ProfileLogin.refer = source["Refer"] as! String
                    ProfileLogin.upper = source["Upper"] as! String
                    
                    if(self.accounttype == "Write"){
                        FIRAuth.auth()!.signIn(withEmail: self.Email.text!, password: self.Password.text!) {
                            (user, error) in
                            
                            if error != nil {
                                // an error occured while attempting login
                                print("Login info is wrong");
                            } else {
                                
                                //Recording the records for adding arrays
                                ProfileLogin.loginemail = self.Email.text!
                                ProfileLogin.password = self.Password.text!
                                ProfileLogin.uid = (user?.uid)!
                                
                                if(BatchPush.lastKnownPushToken() != nil){
                                    ProfileLogin.phoneid = BatchPush.lastKnownPushToken()
                                }
                                else if(BatchPush.lastKnownPushToken() == nil){
                                    //Do Nothing
                                }
                                
                                self.ref.child(byAppendingPath: ProfileLogin.uid as String).child("Phoneid").setValue(ProfileLogin.phoneid)
                                
                                var contactarr = [
                                    "phoneid": ProfileLogin.phoneid,
                                    "uid": ProfileLogin.uid
                                ]
                                self.ref.child("dygW8oXUlSQ1OvZ1nEOZ6RJVAJR2").child("Contacts").child(ProfileLogin.uid + "_contact").setValue(contactarr)
                                
                                //Load to next storypage
                                self.loadDestinationVC();
                                
                            }
                        }
                    }
                    else{
                        self.Exception.text = "你没有读写权限，请加入我们并成为版主"
                        self.Exception.textColor = UIColor.red
                    }
            }
        })
    }
    
    override func viewDidLoad() {
        
        if(language == "english"){
            language = "english"
            self.LoginPage.text = "App User Login"
            self.EmailTitle.text = "Email"
            self.PasswordTitle.text = "Password"
            self.LoginButtonTitle.text = "Login"
            self.Back.text = "Back"
            self.link = "en-US"
        }
        else if(language == "traditional"){
            language = "traditional"
            self.LoginPage.text = "版主登入"
            self.EmailTitle.text = "電郵"
            self.PasswordTitle.text = "密碼"
            self.LoginButtonTitle.text = "登入"
            self.Back.text = "返回前頁"
            self.link = "zh-US"
        }
        else if(language == "simplified"){
            language = "simplified"
            self.LoginPage.text = "版主登入"
            self.EmailTitle.text = "电邮"
            self.PasswordTitle.text = "密码"
            self.LoginButtonTitle.text = "登入"
            self.Back.text = "返回前页"
            self.link = "zh-US"
        }

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "ProfileLogin", sender: nil)
    }
    
    func loadfirstpage(){
        self.performSegue(withIdentifier: "loadfirst", sender: nil)
    }
    
    func loadmenu(){
        self.performSegue(withIdentifier: "loadmenu", sender: nil)
    }
    
};
