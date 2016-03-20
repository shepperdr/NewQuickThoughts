//
//  Journal.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

class Journal: Equatable {
    
    private let titleKey = "title"
    
    var title: String
    let ref: Firebase?
    let user: String
    
    init(title:String) {
        
        self.title = title
        self.ref = nil
        self.user = ""
    }
    
    init(snapshot: FDataSnapshot) {
        
        title = snapshot.value["title"] as! String
        user = snapshot.value["user"] as! String
        ref = snapshot.ref
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let title = dictionary[titleKey] as? String, user = dictionary["user"] as? String else{
            
            self.title = ""
            self.ref = nil
            self.user = ""
            
            return nil
        }
        
        self.user = user
        self.title = title
        self.ref = nil
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        let dictionary = [titleKey : self.title]
        
        return dictionary
    }
}

func == (lhs:Journal, rhs:Journal) ->Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}