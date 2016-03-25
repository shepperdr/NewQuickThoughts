//
//  LoginViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FirebaseController.base
        if ref.authData != nil {
            // user authenticated
            print("\(ref.authData)")
            print("\(ref.authData.providerData)")
            print("\(ref.authData.provider)")
            print("\(ref.authData.uid)")
            print("\(ref.authData.auth)")
            print("\(ref.authData.description)")
            guard let authDictionary = ref.authData.providerData as? [String: AnyObject] else { return }
            UserController.sharedInstance.loginUser(authDictionary["email"] as! String, password: ref.authData.provider, completion: { (user, error) -> Void in
                
                if let error = error, errorCode = FAuthenticationError(rawValue: error.code) {
                    var alertTitle = ""
                    switch (errorCode) {
                    case .UserDoesNotExist:
                        alertTitle = "This user does not exist"
                    case .InvalidEmail:
                        alertTitle = "Invalid email"
                    case .InvalidPassword:
                        alertTitle = "Password does not match email"
                    default:
                        return
                    }
                    let errorAlert = UIAlertController(title: alertTitle, message: "If you have an account, please check your information and try again. If you do not Sign Up!", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    errorAlert.addAction(OKAction)
                    
                    let signupAction = UIAlertAction(title: "Sign Up!", style: .Default) { (_) in
                        self.performSegueWithIdentifier("toSignUp", sender: self)
                    }
                    
                    errorAlert.addAction(signupAction)
                    
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
                self.passwordTextField.text = ""
                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("loginSegue", sender: self)
            })

//            UserController.sharedInstance.currentUser = UserController.sharedInstance.loginUser(authDictionary["email"] as! String, password: ref.authData.provider, completion: { (user, error) -> Void in
//                self.performSegueWithIdentifier("loginSegue", sender: self)
//            })
            
        
        } else {
            // No user is signed in
        }
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
            UserController.sharedInstance.loginUser(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) -> Void in
                
                    if let error = error, errorCode = FAuthenticationError(rawValue: error.code) {
                        var alertTitle = ""
                        switch (errorCode) {
                        case .UserDoesNotExist:
                            alertTitle = "This user does not exist"
                        case .InvalidEmail:
                            alertTitle = "Invalid email"
                        case .InvalidPassword:
                            alertTitle = "Password does not match email"
                        default:
                            return
                        }
                        let errorAlert = UIAlertController(title: alertTitle, message: "If you have an account, please check your information and try again. If you do not Sign Up!", preferredStyle: .Alert)
                        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        errorAlert.addAction(OKAction)
                        
                        let signupAction = UIAlertAction(title: "Sign Up!", style: .Default) { (_) in
                            self.performSegueWithIdentifier("toSignUp", sender: self)
                        }
                        
                        errorAlert.addAction(signupAction)
                        
                        self.presentViewController(errorAlert, animated: true, completion: nil)
                        self.activityIndicator.stopAnimating()
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