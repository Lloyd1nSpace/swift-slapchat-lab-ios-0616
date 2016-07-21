//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Lloyd W. Sykes on 7/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    @IBOutlet weak var addMessageField: UITextField!
    let dataStore = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let messageDescription = NSEntityDescription.entityForName("Message", inManagedObjectContext: self.dataStore.managedObjectContext)
        
        if let messageDescription = messageDescription {
        
        let addMessage = Message(entity: messageDescription, insertIntoManagedObjectContext: self.dataStore.managedObjectContext)
        addMessage.content = self.addMessageField.text
        addMessage.createdAt = NSDate()
        self.dataStore.messages.append(addMessage)
        }
        self.dataStore.saveContext()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
