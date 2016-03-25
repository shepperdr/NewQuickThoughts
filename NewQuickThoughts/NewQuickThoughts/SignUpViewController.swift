//
//  SignUpViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit
import Firebase

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
            UserController.sharedInstance.createUser(emailTextField.text!, password: password.text!) { (user, error) -> Void in
                
                if let error = error, errorCode = FAuthenticationError(rawValue: error.code) {
                    var alertTitle = ""
                    switch (errorCode) {
                    case .EmailTaken:
                        alertTitle = "There is already an account associated with this email"
                    case .InvalidEmail:
                        alertTitle = "This email is invalid"
                    default:
                        return
                    }
                    let errorAlert = UIAlertController(title: alertTitle, message: "Please verify your email and try again.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    errorAlert.addAction(OKAction)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    return
                }
                self.performSegueWithIdentifier("submitSegue", sender: self)
            }
        } else {
            let errorAlert = UIAlertController(title: "Password fields do not match", message: "Please verify your password and try again.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            errorAlert.addAction(OKAction)
            self.presentViewController(errorAlert, animated: true, completion: nil)
            self.password.text = ""
            self.emailTextField.text = ""
            self.confirmPassword.text = ""
        }
    }
    
}
