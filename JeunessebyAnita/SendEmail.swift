//
//  SendEmail.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/19/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import UIKit

class SendEmail:UIViewController{
    
    override func viewDidLoad() {
        sendemail()
    }
    
    @IBAction func loadtologin(_ sender: AnyObject) {
        loadDestinationVC()
    }
    
    func sendemail(){
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "cccyh123@gmail.com"
        smtpSession.password = "Anitalui11"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: Registergroup.registername, mailbox: Registergroup.loginemail)]
        builder.header.from = MCOAddress(displayName: "Jeunesse Anita Team", mailbox: "cccyh123@gmail.com")
        builder.header.subject = "欢迎来到Anita的Jeunesse团队"
        builder.htmlBody = "你的账户已经成功建立 - " + "\n" + "邮件帐户：" + Registergroup.loginemail + "\n" + "密碼：" + Registergroup.password
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "loadlogin", sender: nil)
    }
    
};
