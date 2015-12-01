//
//  Thoughts.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

class Thoughts: Equatable {
    
    private let titleKey = "title"
    private let bodyTextKey = "bodyText"
    
    let ref: Firebase?
    
    var title: String
    var bodyText: String
    
    init(title:String, bodyText: String) {
        self.bodyText = bodyText
        self.title = title
        self.ref = nil
        
    }
    
    init(snapshot: FDataSnapshot) {
        title = snapshot.value["title"] as! String
        bodyText = snapshot.value["bodyText"] as! String
        ref = snapshot.ref
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let title = dictionary[titleKey] as? String,
            let bodyText = dictionary[bodyTextKey] as? String else {
                
                self.title = ""
                self.bodyText = ""
                self.ref = nil
                return nil
        }
        
        self.bodyText = bodyText
        self.title = title
        self.ref = nil
        
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        let dictionary = [
            titleKey : self.title,
            bodyTextKey : self.bodyText ]
        
        return dictionary
    }
}

func == (lhs:Thoughts, rhs:Thoughts) ->Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}