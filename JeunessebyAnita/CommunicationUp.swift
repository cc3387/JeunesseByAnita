//
//  Communication.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/22/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch
import Firebase

class CommunicationUp:UIViewController{

    @IBOutlet weak var communicationboard: UITextView!
    @IBOutlet weak var entertext: UITextField!
    var messages = [String]()
    var time = [String]()
    
    var ref = FIRDatabase.database().reference()
    
    @IBAction func Distributor(_ sender: AnyObject) {
        if(ProfileLogin.joinlink == ""){
            if let url = NSURL(string: "https://joffice.jeunesseglobal.com/signup.asp?locale=zh-US&siteurl=simplyeffective") {
                UIApplication.shared.openURL(url as URL)
            }
        }
        else{
            if let url = NSURL(string: ProfileLogin.joinlink) {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    
    @IBAction func Send(_ sender: AnyObject) {
        
        if(ProfileLogin.password != "" && self.entertext.text != ""){
        let date = NSDate();
        var formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
        let defaultTimeZoneStr = formatter.string(from: date as Date);
        
        var message = [
            "message": self.entertext.text! + " " + "--" + ProfileLogin.name,
            "time": "\(defaultTimeZoneStr)"
        ]
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.upper).observe(.childAdded, with: { snapshot in
            if let source = snapshot.value as? [String:AnyObject] {
                let uid = source["uid"] as! String
                self.ref.child(uid).child("Communication").childByAutoId().setValue(message)
            }
        })
        }
        
        self.entertext.text = "";
        
    }
    
    
    override func viewDidLoad() {
        
        var ref = FIRDatabase.database().reference()
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.upper).observe(.childAdded, with: { snapshot in
            if let source = snapshot.value as? [String:AnyObject] {
                let uid = source["uid"] as! String
                
                //Loading the message query
                ref.child(uid).child("Communication").queryLimited(toLast: 1000).observe(.childAdded, with:{ snapshot in
                    if let sourceone = snapshot.value as? [String:AnyObject] {
                        
                        let message = sourceone["message"] as! String
                        let time = sourceone["time"] as! String
                        
                        self.messages.append(message)
                        self.time.append(time)
                        
                        var finaltext = "";
                        
                        for (ind,time) in zip(self.messages.reversed(),self.time.reversed()){
                            finaltext += ind + "\n" + time + "\n" + "\n";
                        }
                        
                        self.communicationboard.text! = finaltext
                        
                    }
                })
            }
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
};
