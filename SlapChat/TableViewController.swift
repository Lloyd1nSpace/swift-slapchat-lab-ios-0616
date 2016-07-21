//
//  TableViewController.swift
//  SlapChat
//
//  Created by susan lovaglio on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let dataStore = DataStore.sharedDataStore
    var tableViewMessages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataStore.fetchData()
        
        self.tableViewMessages = self.dataStore.messages
        
        if self.tableViewMessages.count == 0 {
            self.generateTestData()
            self.tableViewMessages = self.dataStore.messages
        }
        
        print("Check out my messages: \(self.tableViewMessages)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dataStore.fetchData()
        self.tableViewMessages = self.dataStore.messages
        self.tableView.reloadData()
    }
    
    func generateTestData() {
        
        let sampleMessage = NSEntityDescription.entityForName("Message", inManagedObjectContext: self.dataStore.managedObjectContext)
        
        if let sampleMessage = sampleMessage {
            var newMessage = Message(entity: sampleMessage, insertIntoManagedObjectContext: self.dataStore.managedObjectContext)
            newMessage.content = "Hey, hope all is well with you!"
            newMessage.createdAt = NSDate()
            self.dataStore.managedObjectContext.insertObject(newMessage)
            
            newMessage = Message(entity: sampleMessage, insertIntoManagedObjectContext: self.dataStore.managedObjectContext)
            newMessage.content = "Keeping my head above water"
            newMessage.createdAt = NSDate()
            self.dataStore.managedObjectContext.insertObject(newMessage)
        }
        self.dataStore.saveContext()
        self.dataStore.fetchData()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("basicCell")
        
        cell?.textLabel?.text = self.tableViewMessages[indexPath.row].content
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewMessages.count
    }
    
    
}
