//
//  UserController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    
    static let sharedInstance = UserController()
    
    var currentUser: User?
    
    func createUser(email: String, password: String, completion: (user: User?, error: NSError?) -> Void) {
        let ref = FirebaseController.userBase
        
        ref.createUser(email, password: password, withValueCompletionBlock: { (error, result) in
            
            if error != nil {
                completion(user: nil, error: error)
            } else {
                if let uid = result["uid"] as? String {
                    ref.updateChildValues([uid : email])
                    
                    self.loginUser(email, password: password, completion: { (user, error) -> Void in
                        completion(user: user, error: error)
                    })
                } else {
                    completion(user: nil, error: error)
                }
            }
            
        })
    }
    
    
    func logoutUser() {
        FirebaseController.currentUserURL.ref.unauth()
        currentUser = nil
    }
    
    func loginUser(email: String, password: String, completion: (user: User?, error: NSError?) -> Void) {
        let ref = FirebaseController.base
        
        ref.authUser(email, password: password, withCompletionBlock: { (error, authData) in
            if error != nil {
                // an error occurred while attempting login
                completion(user: nil, error: error)
            } else {
                let uid = authData.uid
                
                self.currentUser = User(email: email, password: password)
                self.currentUser?.ref = uid
                completion(user: self.currentUser, error: error)
            }
        })
    }
    
    func deleteUser() {
        let ref =  FirebaseController.base
        ref.removeUser(currentUser?.email, password: currentUser?.password,
                       withCompletionBlock: { error in
                        if error != nil {
                            // There was an error processing the request
                        } else {
                            // Password changed successfully
                        }
        })
        FirebaseController.currentUserURL.removeValue()
        currentUser = nil
    }
    
    func changePassword(oldPassword: String, newPassword: String, completion: (NSError?) -> Void) {
        let ref = FirebaseController.base
        ref.changePasswordForUser(currentUser?.email, fromOld: oldPassword,
                                  toNew: newPassword, withCompletionBlock: { error in
                                    completion(error)
        })
    }
}
