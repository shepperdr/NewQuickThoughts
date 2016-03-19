//
//  User.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

class User: Equatable {
    
    var email: String
    var password: String
    var ref: String?
    
    private let userKey = "user"
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let email = dictionary["email"] as? String, password = dictionary["password"] as? String else{
            
            self.email = ""
            self.password = ""
            
            return nil
        }
        
        self.email = email
        self.password = password
        
    }

}



func == (lhs: User, rhs: User) -> Bool {
    
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
