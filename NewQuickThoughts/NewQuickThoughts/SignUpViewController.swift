//
//  SignUpViewController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var createUserName: UITextField!
    @IBOutlet weak var passwordStepOne: UITextField!
    @IBOutlet weak var passwordStepTwo: UITextField!
    @IBOutlet weak var validEmailAddress: UITextField!
    
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
        border.frame = CGRect(x: 0, y: createUserName.frame.size.height - width, width: createUserName.frame.size.width, height: createUserName.frame.size.height)
        
        // passwordStepOne textfield
        border.frame = CGRect(x: 0, y: passwordStepOne.frame.size.height - width, width: passwordStepOne.frame.size.width, height: passwordStepOne.frame.size.height)
        
        // passwordStepTwo textfield
        border.frame = CGRect(x: 0, y: passwordStepTwo.frame.size.height - width, width: passwordStepTwo.frame.size.width, height: passwordStepTwo.frame.size.height)
        
        // validEmailAddress textfield
        border.frame = CGRect(x: 0, y: validEmailAddress.frame.size.height - width, width: validEmailAddress.frame.size.width, height: validEmailAddress.frame.size.height)
        
        border.borderWidth = width
        
        createUserName.layer.addSublayer(border)
        createUserName.layer.masksToBounds = true
        
        passwordStepOne.layer.addSublayer(border)
        passwordStepOne.layer.masksToBounds = true
        
        passwordStepTwo.layer.addSublayer(border)
        passwordStepTwo.layer.masksToBounds = true
        
        validEmailAddress.layer.addSublayer(border)
        validEmailAddress.layer.masksToBounds = true
    }
    
}
