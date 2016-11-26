//
//  Setting.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/12/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import Batch
import Firebase
import UIKit
import MessageUI

class Setting:UIViewController, MFMailComposeViewControllerDelegate{
    
    
    @IBOutlet weak var AnitaTeamTitle: UILabel!
    @IBOutlet weak var ReceiveMessageTitle: UILabel!
    @IBOutlet weak var UserGuideTitle: UILabel!
    @IBOutlet weak var PrivacyandTermsTitle: UILabel!
    @IBOutlet weak var Back: UILabel!
    @IBOutlet weak var ContactUsTitle: UILabel!
    var link = "en-US"
    
    ////////////////////////////////////////////////////////////////////////////
    
    @IBOutlet weak var ReceiveMessage: UISwitch!
    
    var ref = FIRDatabase.database().reference()
    
    ////////////////////////////////////////////////////////////////////////////
    
    @IBAction func guideone(_ sender: Any) {
        
        var product = "https://simplyeffective.jeunesseglobal.com/" + self.link + "/terms-of-service"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func guidetwo(_ sender: Any) {
        
        var product = "https://simplyeffective.jeunesseglobal.com/" + self.link + "/privacy-policy"
        
        if let url = NSURL(string: product) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(language == "english"){
            self.link = "en-US"
            self.AnitaTeamTitle.text = "Anita's Jeunesse"
            self.ReceiveMessageTitle.text = "Messages"
            self.UserGuideTitle.text = "Terms of Use"
            self.PrivacyandTermsTitle.text = "Privacy and Terms"
            self.ContactUsTitle.text = "Contact Us"
            self.Back.text = "Back"
        }
        else if(language == "traditional"){
            self.link = "zh-US"
            self.AnitaTeamTitle.text = "Anita 團隊"
            self.ReceiveMessageTitle.text = "接受訊息"
            self.UserGuideTitle.text = "使用條款"
            self.PrivacyandTermsTitle.text = "私隱保密條款"
            self.ContactUsTitle.text = "聯絡我們"
            self.Back.text = "回到前頁"
        }
        else if(language == "simplified"){
            self.link = "zh-US"
            self.AnitaTeamTitle.text = "Anita 团队"
            self.ReceiveMessageTitle.text = "接受讯息"
            self.UserGuideTitle.text = "使用条款"
            self.PrivacyandTermsTitle.text = "私隐保密条款"
            self.ContactUsTitle.text = "联络我们"
            self.Back.text = "回到前页"
        }

        ////////////////////////////////////////////////////////////////////////////////////////////////////
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.endEditing(true)
    }
    
    
    @IBAction func ReceiveMessageAction(_ sender: UISwitch) {
        
        if sender.isOn{
            if(ProfileLogin.uid != ""){
            ref.child(ProfileLogin.uid).child("notification").setValue("1")
            }
        }else{
            if(ProfileLogin.uid != ""){
                ref.child(ProfileLogin.uid).child("notification").setValue("0")
            }
        }
    }
    
    
    @IBAction func ContactUs(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["cccyh123@gmail.com"])
        mailComposerVC.setSubject("Contact Administrater")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWith result: MFMailComposeResult, error: Error!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
};
