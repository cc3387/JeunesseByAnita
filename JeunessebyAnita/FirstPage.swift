//
//  FirstPage.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/22/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch
import Firebase

class FirstPage:UIViewController{
    
    @IBOutlet weak var ReferralWarning: UILabel!
    @IBOutlet weak var Referral: UITextField!
    @IBAction func ReferralLogin(_ sender: AnyObject) {
        
        ProfileLogin.loginemail = self.Referral.text!
        
        
        if(self.Referral.text != ""){
        var ref = FIRDatabase.database().reference()
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: ProfileLogin.loginemail).observe(.childAdded, with: { snapshot in
            if let source = snapshot.value as? [String:AnyObject] {
                
                ProfileLogin.name = source["Owner"] as! String!
                ProfileLogin.shoplink = source["Shoplink"] as! String!
                ProfileLogin.joinlink = source["Joinlink"] as! String!
                ProfileLogin.foreword = source["Foreword"] as! String!
                ProfileLogin.refer = source["Refer"] as! String!
                ProfileLogin.upper = source["Upper"] as! String!
                
            }
        })
            
        //Load to the next viewcontroller
        loadDestinationVC()
            
        }
        else{
            self.ReferralWarning.textColor = UIColor.red
        }
        
    }
    
    @IBAction func JoinAnita(_ sender: AnyObject) {
        if let url = NSURL(string: "https://simplyeffective.jeunesseglobal.com/zh-US") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "ReferralSend", sender: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
};

///////////////////////////// Structs For Login ///////////////////////////////////////

struct ProfileLogin{
    static var loginemail = "";
    static var password = "";
    static var uid = "";
    static var phoneid = "";
    static var shoplink = "";
    static var joinlink = "";
    static var foreword = "";
    static var educationlink = "";
    static var refer = "";
    static var name = "Anita";
    static var upper = "";
};

struct Registergroup{
    static var loginemail = "";
    static var password = "";
    static var registername = "";
    static var finalupper = "";
}
