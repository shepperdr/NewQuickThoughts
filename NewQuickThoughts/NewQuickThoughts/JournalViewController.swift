//
//  JournalViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the NavigationController color clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        FirebaseController.sharedInstance.fetchAllJournals { () -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        
        let nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserver(self, selector: "journalsUpdated:", name: journalsUpdateNotification, object: nil)
        
    }
    
    func thoughtsUpdated(notification: NSNotification) {
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("journalCell", forIndexPath: indexPath)
        
        let journal = JournalController.sharedInstance.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JournalController.sharedInstance.journals.count
    }
    
    //    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        mmm
    //    }
    
    //    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        if editingStyle == .Delete {
    //
    //            let journal = JournalController.sharedInstance.journals[indexPath.row]
    //
    //            let alert = UIAlertController(title: "Change Journal Title", message: "What do you want the new title to be?", preferredStyle: UIAlertControllerStyle.Alert)
    //
    //            alert.addTextFieldWithConfigurationHandler( { (textField: UITextField) -> Void in
    //                textField.placeholder = "Journal Title"
    //            })
    //
    //            let action0 = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    //
    //            alert.addAction(action0)
    //            let textField = alert.textFields![0]
    //
    //            let action1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (_) -> Void in
    //                // this works with the exact ID in it.
    //
    //                FirebaseController.journalBase.childByAppendingPath("-K3nR1tMYkVpO3NwfCMj").updateChildValues(["title": textField.text!])
    //                //                self.tableView.reloadData()
    //            }
    //
    //
    //            JournalController.sharedInstance.removeJournal(journal)
    //
    //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    //
    //        }
    //    }
    
    @IBAction func addJournal(sender: AnyObject) {
        let alert = UIAlertController(title: "New Journal", message: "Add a title to your new Journal.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler( { (textField: UITextField) -> Void in
            textField.placeholder = "Journal Title"
        })
        
        let action0 = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(action0)
        let textField = alert.textFields![0]
        
        let action1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (_) -> Void in
            
            FirebaseController.base.childByAppendingPath("journal").childByAutoId().setValue(["title": textField.text!])
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showThoughts"  {
            if let detailVC = segue.destinationViewController as? ThoughtsViewController {
                _ = detailVC.view
                
                let indexPath = tableView.indexPathForSelectedRow
                
                if let selectedRow = indexPath?.row {
                    
                    let journal = JournalController.sharedInstance.journals[selectedRow]
                    detailVC.journal = journal
                    
                }
            }
        }
        
    }
}