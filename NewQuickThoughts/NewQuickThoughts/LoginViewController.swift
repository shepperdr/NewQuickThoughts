//
//  LoginViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // This adds some design to the Username and password textFields
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat (0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        
        // Username textField
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height - width, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height)
        
        // Password textfield
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - width, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        
        border.borderWidth = width
        
        emailTextField.layer.addSublayer(border)
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.addSublayer(border)
        passwordTextField.layer.masksToBounds = true
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        print("login tapped")
        
        if !(passwordTextField.text == "" && emailTextField.text == "") {
            self.activityIndicator.startAnimating()
            UserController.sharedInstance.loginUser(emailTextField.text!, password: passwordTextField.text!, completion: { (user) -> Void in
                if UserController.sharedInstance.currentUser == nil {
                    
                    print("error loading user")
                    
                    let errorAlert = UIAlertController(title: "Something went wrong when you tried to log in", message: "If you have an account already, please check your information and try again. If you don't have an account Sign Up!", preferredStyle: .Alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    
                    errorAlert.addAction(OKAction)
                    
                    let signupAction = UIAlertAction(title: "Sign Up!", style: UIAlertActionStyle.Destructive) { (_) -> Void in
                        
                        self.performSegueWithIdentifier("toSignUp", sender: self)
                    }
                    
                    errorAlert.addAction(signupAction)
                    
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    return
                }
                self.passwordTextField.text = ""
                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            })
            
        }
        
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