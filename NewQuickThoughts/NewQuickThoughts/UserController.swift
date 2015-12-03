//
//  UserController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation

//class UserController {
//    
//    static let sharedInstance = UserController()
//    
//    var currentUser: User?
//    
//    func createUser(username: String, email: String, password: String, completion: (user: User?) -> Void) {
//        let ref = FirebaseController.base
//        
//        ref.createUser(email, password: password, username: username, withValueCompletionBlock: { (error, result) in
//            
//            if error != nil {
//                completion(user: nil)
//            } else {
//                if let uid = result["uid"] as? String {
//                    let userRef = ref.childByAppendingPath("users")
//                    userRef.updateChildValues([uid : username])
//                    
//                    self.loginUser(email, password: password, username: username, completion: { (user) -> Void in
//                        completion(user: user)
//                    })
//                } else {
//                    completion(user: nil)
//                }
//            }
//            
//        })
//    }
//    
//    func loginUser(email: String, password: String, username: String, completion: (user: User?) -> Void) {
//        let ref = FirebaseController.base
//        
//        ref.authUser(email, password: password, withCompletionBlock: { (error, authData) in
//            if error != nil {
//                completion(user: nil)
//            } else {
//                let uid = authData.uid
//                
//                let endpoint = "users/\(uid)"
//                
//                FirebaseController.dataAtEndpoint(endpoint, completion: { (data) -> Void in
//                    if let newUser = data as? String {
//                        self.currentUser = User(email: uid, password: username, username: shepperdr)
//                        completion(user: self.currentUser)
//                    } else {
//                        completion(user: nil)
//                    }
//                })
//            }
//        })
//    }
//    
//}
