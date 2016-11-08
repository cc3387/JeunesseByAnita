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
    
    
    @IBOutlet weak var ReceiveMessage: UISwitch!
    var ref = FIRDatabase.database().reference()
    
    @IBAction func guidlines(_ sender: AnyObject) {
        if let url = NSURL(string: "https://www.jeunesseglobal.com/zh-US/terms-of-service") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func guidelinestwo(_ sender: AnyObject) {
        
        if let url = NSURL(string: "https://www.jeunesseglobal.com/zh-US/privacy-policy") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.endEditing(true)
    }
    
    @IBAction func ContactUs(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
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
    
    
    @IBAction func Send_Email(sender: AnyObject) {
        
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
