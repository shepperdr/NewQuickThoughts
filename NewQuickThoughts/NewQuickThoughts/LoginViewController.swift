//
//  LoginViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // This adds some design to the Username and password textFields
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat (0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        
        // Username textField
        border.frame = CGRect(x: 0, y: userNameTextField.frame.size.height - width, width: userNameTextField.frame.size.width, height: userNameTextField.frame.size.height)
        
        // Password textfield
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - width, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        
        border.borderWidth = width
        
        userNameTextField.layer.addSublayer(border)
        userNameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.addSublayer(border)
        passwordTextField.layer.masksToBounds = true
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