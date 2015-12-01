//
//  SettingsViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func cancel(sender: AnyObject) {
        navigationController?.popToViewController(UIViewController() as! JournalViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        print("Logout Tapped")
    }
    
    @IBAction func contactUsButtonTapped(sender: AnyObject) {
        print("Contact Tapped")
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
