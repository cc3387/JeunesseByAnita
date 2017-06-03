//
//  ViewController.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/4/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import UIKit
import StoreKit
import Firebase

protocol IAPurchaceViewControllerDelegate {
    func didBuyColorsCollection(collectionIndex: Int)
}

class IAPurchaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate{
    
    
    @IBOutlet weak var Warning: UILabel!
    
    //Variables
    var productIDs: Array<String?> = []
    var productsArray: Array<SKProduct?> = []
    
    //Find Selected Products
    var selectedProductIndex: Int!
    var transactionInProgress = false

    //Delegate For IAPurchase
    var delegate: IAPurchaceViewControllerDelegate!
    
    //TableView
    @IBOutlet weak var tblProducts: UITableView!
    
    override func viewDidLoad() {
        
        //Append ID
        productIDs.append("com_jeunesse_anita")
        
        //Request Product Information
        requestProductInfo()
        tblProducts.delegate = self
        tblProducts.dataSource = self

    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //Request In App Purchase Product Information
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as Set<NSObject> as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            print("Cannot perform In App Purchases.")
        }
    }
    
    
    //Handling product response
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product)
            }
            
            print("\(response.products.count) " + " product was found")
            
            tblProducts.reloadData()
        }
        else {
            print("There are no products.")
        }
        
        if response.invalidProductIdentifiers.count != 0 {
            print(response.invalidProductIdentifiers.description)
        }
    }

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellProduct", for: indexPath as IndexPath)
        
        //Change to Subtitle
        let product = productsArray[indexPath.row]
        cell.textLabel?.text = (product?.localizedTitle)! + " Monthly Subscription"
        cell.detailTextLabel?.text = "$" + (product?.price.stringValue)! + " per month (Auto Monthy Renewal Unless Cancelled)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProductIndex = indexPath.row
        showActions()
        tableView.cellForRow(at: indexPath as IndexPath)?.isSelected = false
    }
    
    @IBAction func Next(_ sender: Any) {
        
        if(Purchase == 0){
                self.Warning.text = "Must Complete Registration!"
                self.Warning.textColor = UIColor.red
        }
        else if(Purchase == 1){
                self.transactionInProgress = false
                self.loadDestinationVC()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        transactionInProgress = false
        
        let user = FIRAuth.auth()?.currentUser
        
        user?.delete{ error in
            if let error = error{
            //An error happened
            }
            else{
            //Account deleted
            }
        }
        
        var ref = FIRDatabase.database().reference()
        ref.child((user?.uid)!).removeValue()
        ref.child("EmailList").child((user?.uid)!).removeValue()
        
        loadDestinationReg()
    }
    
    
    
    //Show Actions
    func showActions() {
        
        
        transactionInProgress = false
        
//        if transactionInProgress {
//        return
//        }
        
        let actionSheetController = UIAlertController(title: "Join Jeunesse Anita Team, 加入婕斯-Anita团队, $0.99 per month/Auto Monthly Renewal Unless Cancelled Manually (每月自动更新$0.99美金除非用户取消) ", message: "Join Now, $0.99 per month/Auto Monthly Renewal Unless Cancelled Manually, 立刻购买 - 每月自动更新$0.99美金除非用户取消. Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal.Users who use this app will have to register for a monthly subscription with $0.99 per month. Price of subscription, and price per issue if appropriate. Payment will be charged to iTunes Account at confirmation of purchase.Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal.Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. Privacy Link - http://simplyeffective.jeunesseglobal.com/en-US/privacy-policy. Terms of use - http://simplyeffective.jeunesseglobal.com/en-US/terms-of-service", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //Buy Action
        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.default) { (action) -> Void in
            
            let payment = SKPayment(product: self.productsArray[self.selectedProductIndex]! as SKProduct)
            SKPaymentQueue.default().add(payment)
            self.transactionInProgress = true
            Purchase = 1;
        }
        
        //Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            self.transactionInProgress = false
            Purchase = 0;
        }
        
        actionSheetController.addAction(buyAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
        
    }
    
    //Payment Queue
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        for transaction in transactions as! [SKPaymentTransaction] {
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                print("Transaction completed successfully.")
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionInProgress = false
                
            case SKPaymentTransactionState.failed:
                print("Transaction Failed");
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionInProgress = false
                
            default:
                print(transaction.transactionState.rawValue)
            }
        }
    }
    
    func loadDestinationVC(){
        self.performSegue(withIdentifier: "loadsendemail", sender: nil)
    }
    
    func loadDestinationReg(){
        self.performSegue(withIdentifier: "BackToReg", sender: nil)
    }
    
};



