//
//  SettingsViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(segue: UIStoryboardSegue) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        print("Logout Tapped")
    }
    
    @IBAction func contactUsButtonTapped(sender: AnyObject) {
        
        let sendMailError = configureContactUsVC()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(sendMailError, animated: true, completion: nil)
        } else {
            self.showSendEmailAlert()
        }

        print("Contact Tapped")
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        print("cancel pressed!")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
   
    
    func configureContactUsVC() -> MFMailComposeViewController {
        
        let contactUsVC = MFMailComposeViewController()
        contactUsVC.mailComposeDelegate = self
        contactUsVC.setToRecipients(["shepperdr@hotmail.com", "hmertlich@gmail.com", "skylertanner@live.com"])
        contactUsVC.setSubject("App Feedback!")
        contactUsVC.setMessageBody("This is sent directly from our app!", isHTML: false)
        
        return contactUsVC
    }
    
    func showSendEmailAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "Email could not be sent", message: "Unable to send at this time", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        sendMailErrorAlert.addAction(defaultAction)
        
        presentViewController(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result {
        case MFMailComposeResultCancelled:
            print("cancelled mail tapped")
            
        case MFMailComposeResultSent:
            print("mail sent tapped")
        default:
            break
            
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    /*
    // MARK: - Navigation
    
     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
