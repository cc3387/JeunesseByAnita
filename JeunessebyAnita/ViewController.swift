//
//  ViewController.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 10/4/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class News: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as UITableViewCell
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        if(indexPath.section == 0){
            cell.backgroundColor = UIColor(red: 240, green: 230, blue: 255)
        }
        else if(indexPath.section == 1){
            cell.backgroundColor = UIColor(red: 240, green: 230, blue: 255)
        }
        else if(indexPath.section == 2){
            //cell.backgroundColor = UIColor(red: 255, green: 102, blue: 102)
        }
        
        return cell;
    }
    
    
    //Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var sections: [Section] = SectionsData().getSectionsFromData()
    var messages = [String]()
    var times = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200;
        tableView.delegate = self
        tableView.dataSource = self
        
        self.messages = [];
        self.times = [];
        
        var ref = FIRDatabase.database().reference()
        
        ref.queryOrdered(byChild: "Email").queryEqual(toValue: "luianita@yahoo.com").observe(.childAdded, with: { snapshot in
                if let source = snapshot.value as? [String:AnyObject] {
                    let uid = source["uid"] as! String

                    //Loading the message query
                    ref.child(uid).child("Messages").queryLimited(toLast: 1000).observe(.childAdded, with:{ snapshot in
                        if let sourceone = snapshot.value as? [String:AnyObject] {
                      
                            let message = sourceone["message"] as! String
                            let time = sourceone["time"] as! String
                            
                            self.messages.append(message)
                            self.times.append(time)
                            
                            var finaltext = "";
                            
                            for (ind,time) in zip(self.messages.reversed(),self.times.reversed()){
                                finaltext += ind + "\n" + time + "\n" + "\n";
                            }
                            
                            self.textView.text = finaltext
                        }
                    })
                }
        })

        self.textView.backgroundColor = UIColor(red: 227, green: 236, blue: 255)
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //Read the whole table with sections
    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as UITableViewCell
        
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        if(indexPath.section == 0){
            cell.backgroundColor = UIColor(red: 240, green: 230, blue: 255)
        }
        else if(indexPath.section == 1){
            cell.backgroundColor = UIColor(red: 240, green: 230, blue: 255)
        }
        else if(indexPath.section == 2){
            //cell.backgroundColor = UIColor(red: 255, green: 102, blue: 102)
        }
        
        return cell;
    }
    
    
    
};


//Class for sections
class SectionsData {
    
    func getSectionsFromData() -> [Section] {
        
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        var sectionsArray = [Section]()
        
        if(language == "english"){
        let frontword = Section(title: ProfileLogin.name + " - Foreword", objects: [ProfileLogin.foreword])
        let news = Section(title: "Team" + " -- News Update", objects: [""])
        sectionsArray.append(frontword)
        sectionsArray.append(news)
        }
        else if(language == "traditional"){
        let frontword = Section(title: ProfileLogin.name + " - 前言", objects: [ProfileLogin.foreword])
        let news = Section(title: "團隊" + " --最新消息", objects: [""])
        sectionsArray.append(frontword)
        sectionsArray.append(news)
        }
        else if(language == "simplified"){
        let frontword = Section(title: ProfileLogin.name + " - 前言", objects: [ProfileLogin.foreword])
        let news = Section(title: "团队" + " --最新消息", objects: [""])
        sectionsArray.append(frontword)
        sectionsArray.append(news)
        }
        
        return sectionsArray
    }
}


struct Section {
    
    var heading : String
    var items : [String]
    
    init(title: String, objects : [String]) {
        heading = title
        items = objects
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}


