//
//  SignUpViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // adds style to the new user textfields
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat (0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        
        // createemailTextField textField
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height - width, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height)
        
        // passwordStepOne textfield
        border.frame = CGRect(x: 0, y: password.frame.size.height - width, width: password.frame.size.width, height: password.frame.size.height)
        
        // passwordStepTwo textfield
        border.frame = CGRect(x: 0, y: confirmPassword.frame.size.height - width, width: confirmPassword.frame.size.width, height: confirmPassword.frame.size.height)
        
        border.borderWidth = width
        
        emailTextField.layer.addSublayer(border)
        emailTextField.layer.masksToBounds = true
        
        password.layer.addSublayer(border)
        password.layer.masksToBounds = true
        
        confirmPassword.layer.addSublayer(border)
        confirmPassword.layer.masksToBounds = true
        
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        if password.text == confirmPassword.text {
            UserController.sharedInstance.createUser(emailTextField.text!, password: password.text!) { (user) -> Void in
                if UserController.sharedInstance.currentUser == nil {
                    let errorAlert = UIAlertController(title: "Unable to sign up", message: "Unable to sign up with this email because it is either in use or entered incorrectly. Please verify your email and try again.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    errorAlert.addAction(OKAction)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    return
                }
                self.performSegueWithIdentifier("submitSegue", sender: self)
            }
        } else {
            print("add alert to indicate passwordTextField and confirmPasswordTextField are not the same")
        }
        
    }
    
    
    
}
