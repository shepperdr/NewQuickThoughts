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
    var username: String
    
    private let userKey = "user"
    
    init(email: String, password: String, username: String) {
        self.email = email
        self.password = password
        self.username = username
    }
}

func == (lhs: User, rhs: User) -> Bool {
    
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
