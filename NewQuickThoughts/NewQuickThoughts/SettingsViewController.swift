//
//  SettingsViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit
import MessageUI
import Firebase


class SettingsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(segue: UIStoryboardSegue) {
        let errorAlert = UIAlertController(title: "Are you sure you want to log out of your account?", message: "", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        errorAlert.addAction(OKAction)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .Destructive) { (_) in
            UserController.sharedInstance.logoutUser()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        errorAlert.addAction(logoutAction)
        
        self.presentViewController(errorAlert, animated: true, completion: nil)
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    @IBAction func deleteUserPressed(sender: AnyObject) {
        let errorAlert = UIAlertController(title: "Are you sure you want to delete your account?", message: "", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        errorAlert.addAction(OKAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (_) in
            UserController.sharedInstance.deleteUser()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        errorAlert.addAction(deleteAction)
        self.presentViewController(errorAlert, animated: true, completion: nil)
       
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

    @IBAction func changePasswordPressed(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Change Password", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler( { (textField: UITextField) -> Void in
            textField.placeholder = "Current Password"
        })
        
        alert.addTextFieldWithConfigurationHandler( { (textField: UITextField) -> Void in
            textField.placeholder = "New Password"
        })
        
        let action0 = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(action0)
        let currentPasswordTextField = alert.textFields![0]
        let newPasswordTextField = alert.textFields![1]
        
        let action1 = UIAlertAction(title: "Update", style: UIAlertActionStyle.Default) { (_) -> Void in
            UserController.sharedInstance.changePassword(currentPasswordTextField.text!, newPassword: newPasswordTextField.text!, completion: { (error) in
                if let error = error, errorCode = FAuthenticationError(rawValue: error.code) {
                    var alertTitle = ""
                    switch (errorCode) {
                    case .InvalidPassword:
                        alertTitle = "Current password is invalid"
                    default:
                        return
                    }
                    let errorAlert = UIAlertController(title: alertTitle, message: "Please verify your current password and try again.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    errorAlert.addAction(OKAction)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                } else {
                    let successAlert = UIAlertController(title: "Your password was successfully changed", message: "", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    successAlert.addAction(OKAction)
                    self.presentViewController(successAlert, animated: true, completion: nil)
                }
            })
        }
        
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: nil)

        
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
