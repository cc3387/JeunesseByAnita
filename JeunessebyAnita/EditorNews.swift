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

class EditorNews:UIViewController{
    
    var ref = FIRDatabase.database().reference()
    var devicetoken = [String]() //phoneid
    var uidarray = [String]() //uid
    
    @IBOutlet weak var News: UITextView!
    @IBOutlet weak var UploadSuccess: UILabel!
    
    override func viewDidLoad() {
        
        //Append all the contact lists
        let contactQuery = ref.child(ProfileLogin.uid).child("Contacts").queryOrdered(byChild: "phoneid")
        
        //Loading the message query
        contactQuery.observe(.childAdded, with:{ snapshot in
            if let source = snapshot.value as? [String:AnyObject] {
                   let phoneid = source["phoneid"] as! String
                   let uid = source["uid"] as! String
                   if(phoneid == ""){
                   self.devicetoken.append("1234567890")
                   }
                   else{
                   self.devicetoken.append(phoneid)
                   }
                   self.uidarray.append(uid)
            }
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func UploadNews(_ sender: AnyObject) {
        
        let date = NSDate();
        var formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
        let defaultTimeZoneStr = formatter.string(from: date as Date);
        
        var message = [
        "message": self.News.text! + "--" + ProfileLogin.name,
        "time": "\(defaultTimeZoneStr)"
        ]
        
        ////////// Upload New Information Session ///////////////////////
         if(self.News.text! != "" && ProfileLogin.loginemail == "luianita@yahoo.com"){
            
         //Write on your own board
         self.ref.child("N2e5r5qWAkV4fAKWbyrJjZkAWs62").child("Messages").childByAutoId().setValue(message)
         self.UploadSuccess.textColor = UIColor.green
         self.News.text = ""
            
        ////////// End of Uploading News ////////////////////////
        
            
        /////////// Push Notification Section //////////////////////////////////////////////////
        let devDeviceToken = self.devicetoken
        print(devDeviceToken)
        
        if let pushClient = BatchClientPush(apiKey: "57F8E63F7E5CEC46E964020BA9C465", restKey: "a524aa85f96b3bc103188428b026bd5b") {
            
            pushClient.sandbox = false
            pushClient.customPayload = ["aps": ["badge": 1] as AnyObject]
            pushClient.groupId = "tests"
            pushClient.message.title = "婕斯 - Anita Team"
            pushClient.message.body = "Anita 上载了新讯息!"
            pushClient.recipients.customIds = ["a524aa85f96b3bc103188428b026bd5b"]
            
            for token in devDeviceToken {
                
                ref.queryOrdered(byChild: "Phoneid").queryEqual(toValue: token)
                    .observe(.childAdded, with: { snapshot in
                        
                        if let source = snapshot.value as? [String:AnyObject] {
                           
                            let notification = source["notification"] as! String
                            
                            if(notification == "1"){
                            pushClient.recipients.tokens.append(token)
                            pushClient.send { (response, error) in
                            if let error = error {
                            print("Something happened while sending the push: \(response) \(error.localizedDescription)")
                            } else {
                            print("Push sent \(response)")
                            }
                            }
                        }
                    }
                })
            }
        } else {
            print("Error while initializing BatchClientPush")
        }
        
        ///////////// End of Push Notification Section //////////////////
    
        }
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
};
