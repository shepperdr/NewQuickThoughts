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
    
    init(title:String) {
        
        self.title = title
        self.ref = nil
        
    }
    
    init(snapshot: FDataSnapshot) {
        
        title = snapshot.value["title"] as! String
        ref = snapshot.ref
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let title = dictionary[titleKey] as? String else{
            
            self.title = ""
            self.ref = nil
            
            return nil
        }
        
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