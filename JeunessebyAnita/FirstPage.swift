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
    
    //List of Labels that will be changed due to language choose
    @IBOutlet weak var AnitaTeamLabel: UILabel!
    @IBOutlet weak var RefererEmail: UILabel!
    @IBOutlet weak var StartBrowsing: UILabel!
    @IBOutlet weak var ToLogin: UILabel!
    @IBOutlet weak var Alreadymember: UILabel!
    @IBOutlet weak var Becomemember: UILabel!
    @IBOutlet weak var ToRegister: UILabel!
    @IBOutlet weak var JoinAnitaTeam: UILabel!
    
    //////////////////////////////////////
    @IBAction func English(_ sender: Any) {
        language = "english"
        self.AnitaTeamLabel.text = "Jeunesse-Anita Team"
        self.RefererEmail.text = "Referrer Email : "
        self.StartBrowsing.text = "Start Browsing"
        self.JoinAnitaTeam.text = "Join Anita's Team Now!"
        self.Alreadymember.text = "Already app user?"
        self.ToLogin.text = "To Login Page"
        self.Becomemember.text = "Become app user!"
        self.ToRegister.text = "To Register Page"
    }
    
    @IBAction func Traditional(_ sender: Any) {
        language = "traditional"
        self.AnitaTeamLabel.text = "婕斯-Anita 團隊"
        self.RefererEmail.text = "介紹人電郵 : "
        self.StartBrowsing.text = "開始瀏覽"
        self.JoinAnitaTeam.text = "立刻加入Anita的團隊!"
        self.Alreadymember.text = "已經是版主?"
        self.ToLogin.text = "立刻登入！"
        self.Becomemember.text = "加入成為版主"
        self.ToRegister.text = "立刻註冊！"
    }
    
    @IBAction func Simplified(_ sender: Any) {
         language = "simplified"
        self.AnitaTeamLabel.text = "婕斯-Anita 团队"
        self.RefererEmail.text = "介绍人电邮 : "
        self.StartBrowsing.text = "开始浏览"
        self.JoinAnitaTeam.text = "立刻加入Anita的团队!"
        self.Alreadymember.text = "已经是版主?"
        self.ToLogin.text = "立刻登入！"
        self.Becomemember.text = "加入成为版主"
        self.ToRegister.text = "立刻注册！"
    }
    
    
    ///////////////////////////////////////
    @IBAction func joinanita(_ sender: Any) {
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
            
            if(language == "english"){
            self.ReferralWarning.text = "Please enter email"
            self.ReferralWarning.textColor = UIColor.red
                
            }
            else if(language == "traditional"){
            self.ReferralWarning.text = "請輸入電郵"
            self.ReferralWarning.textColor = UIColor.red
            }
            else if(language == "simplified"){
                self.ReferralWarning.text = "請输入电邮"
                self.ReferralWarning.textColor = UIColor.red
            }
        }
        
    }
    
    override func viewDidLoad() {
        
        self.Referral.text = "luianita@yahoo.com"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        if(language == "english"){
            
            self.AnitaTeamLabel.text = "Jeunesse-Anita Team"
            self.RefererEmail.text = "Referrer Email : "
            self.StartBrowsing.text = "Start Browsing"
            self.JoinAnitaTeam.text = "Join Anita's Team Now!"
            self.Alreadymember.text = "Already app user?"
            self.ToLogin.text = "To Login Page"
            self.Becomemember.text = "Become app user!"
            self.ToRegister.text = "To Register Page"
        }
        else if(language == "traditional"){
            
            self.AnitaTeamLabel.text = "婕斯-Anita 團隊"
            self.RefererEmail.text = "介紹人電郵: "
            self.StartBrowsing.text = "開始瀏覽"
            self.JoinAnitaTeam.text = "立刻加入Anita的團隊!"
            self.Alreadymember.text = "已經是版主?"
            self.ToLogin.text = "立刻登入！"
            self.Becomemember.text = "加入成為版主"
            self.ToRegister.text = "立刻註冊！"
        }
        else if(language == "simplified"){
            self.AnitaTeamLabel.text = "婕斯-Anita 团队"
            self.RefererEmail.text = "介绍人电邮 : "
            self.StartBrowsing.text = "开始浏览"
            self.JoinAnitaTeam.text = "立刻加入Anita的团队!"
            self.Alreadymember.text = "已经是版主?"
            self.ToLogin.text = "立刻登入！"
            self.Becomemember.text = "加入成为版主"
            self.ToRegister.text = "立刻注册！"
        }
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
