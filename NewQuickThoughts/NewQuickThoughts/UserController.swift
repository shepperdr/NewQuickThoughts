//
//  UserController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedInstance = UserController()
    
    var currentUser: User?
    
    func createUser(email: String, password: String, completion: (user: User?) -> Void) {
        let ref = FirebaseController.userBase
        
        ref.createUser(email, password: password, withValueCompletionBlock: { (error, result) in
            
            if error != nil {
                completion(user: nil)
            } else {
                if let uid = result["uid"] as? String {
                    ref.updateChildValues([uid : email])
                    
                    self.loginUser(email, password: password, completion: { (user) -> Void in
                        completion(user: user)
                    })
                } else {
                    completion(user: nil)
                }
            }
            
        })
    }
    
    
    func logoutUser() {
        FirebaseController.currentUserURL.ref.unauth()
    }
    func loginUser(email: String, password: String, completion: (user: User?) -> Void) {
        let ref = FirebaseController.base
        
        ref.authUser(email, password: password, withCompletionBlock: { (error, authData) in
            if error != nil {
                completion(user: nil)
            } else {
                let uid = authData.uid
                
                let endpoint = "users/\(uid)"
                
                FirebaseController.dataAtEndpoint(endpoint, completion: { (data) -> Void in
                    if let newUser = data as? String {
                        self.currentUser = User(email: email, password: password)
                        self.currentUser?.ref = uid
                        completion(user: self.currentUser)
                    } else {
                        completion(user: nil)
                    }
                })
            }
        })
    }
    
}
