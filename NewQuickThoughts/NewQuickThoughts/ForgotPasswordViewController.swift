//
//  ForgotPasswordViewController.swift
//  NewQuickThoughts
//
//  Created by Skyler John Tanner on 3/23/16.
//  Copyright © 2016 Robert Shepperd. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPasswordPressed(sender: AnyObject) {
        let ref = FirebaseController.base
        ref.resetPasswordForUser(emailTextField.text, withCompletionBlock: { error in
            if error != nil {
                // There was an error processing the request alert
            } else {
                // Password reset sent successfully alert
            }
            self.navigationController?.popViewControllerAnimated(true)
        })
    }

}
