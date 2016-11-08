//
//  ViewController.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/4/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import UIKit
import StoreKit

protocol IAPurchaceViewControllerDelegate {
    func didBuyColorsCollection(collectionIndex: Int)
}

class IAPurchaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate{
    
    
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
        cell.textLabel?.text = product?.localizedTitle
        cell.detailTextLabel?.text = "$" + (product?.price.stringValue)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProductIndex = indexPath.row
        showActions()
        loadDestinationVC()
        tableView.cellForRow(at: indexPath as IndexPath)?.isSelected = false
    }
    
    //Show Actions
    func showActions() {
        if transactionInProgress {
            return
        }
        
        let actionSheetController = UIAlertController(title: "加入婕斯-Anita团队", message: "立刻购买", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //Buy Action
        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.default) { (action) -> Void in
            
            let payment = SKPayment(product: self.productsArray[self.selectedProductIndex]! as SKProduct)
            SKPaymentQueue.default().add(payment)
            self.transactionInProgress = true
            
        }
        
        //Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
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
    
};
