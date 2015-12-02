//
//  SignUpViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    
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
        
        // createUserName textField
        border.frame = CGRect(x: 0, y: username.frame.size.height - width, width: username.frame.size.width, height: username.frame.size.height)
        
        // passwordStepOne textfield
        border.frame = CGRect(x: 0, y: password.frame.size.height - width, width: password.frame.size.width, height: password.frame.size.height)
        
        // passwordStepTwo textfield
        border.frame = CGRect(x: 0, y: confirmPassword.frame.size.height - width, width: confirmPassword.frame.size.width, height: confirmPassword.frame.size.height)
        
        // validEmailAddress textfield
        border.frame = CGRect(x: 0, y: emailAddress.frame.size.height - width, width: emailAddress.frame.size.width, height: emailAddress.frame.size.height)
        
        border.borderWidth = width
        
        username.layer.addSublayer(border)
        username.layer.masksToBounds = true
        
        password.layer.addSublayer(border)
        password.layer.masksToBounds = true
        
        confirmPassword.layer.addSublayer(border)
        confirmPassword.layer.masksToBounds = true
        
        emailAddress.layer.addSublayer(border)
        emailAddress.layer.masksToBounds = true
    }
    
}
