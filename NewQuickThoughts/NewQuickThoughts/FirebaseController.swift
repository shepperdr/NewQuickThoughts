//
//  FirebaseController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let sharedInstance = FirebaseController()
    
    static let base = Firebase(url: "https://quickthoughts.firebaseio.com/")
    static let userBase = base.childByAppendingPath("users")
    static let journalBase = base.childByAppendingPath("journal")
    static let journalNameRef = Firebase(url: "https://quickthoughts.firebaseio.com/journal/")
//    static let currentUserURL = userBase.childByAppendingPath(UserController.sharedInstance.currentUser!.ref!)
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        let firebaseEndpoint = FirebaseController.base.childByAppendingPath(endpoint)
        
        firebaseEndpoint.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
    
    func fetchAllJournals(completion: () -> () ) {
        FirebaseController.journalBase.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            let arrayOfJournals = snapshot.children.allObjects
            JournalController.sharedInstance.journals = (arrayOfJournals.map{ Journal.init(snapshot: $0 as! FDataSnapshot)
                })
            let journals = JournalController.sharedInstance.journals as [Journal] ?? []
            JournalController.sharedInstance.journals = journals.filter{($0.user == UserController.sharedInstance.currentUser?.ref)}
            
            completion()
        })
        
    }
    
    func fetchAllThoughts(journal: Journal, completion: () -> () ) {
        
        let specificJournalRef = "\(journal.ref)"
        print(specificJournalRef)
        let specificJournalUID = specificJournalRef.substringWithRange(Range<String.Index>(start: specificJournalRef.startIndex.advancedBy(54), end: specificJournalRef.endIndex.advancedBy(-1)))
        print(specificJournalUID)
        
        FirebaseController.journalBase.childByAppendingPath(specificJournalUID).childByAppendingPath("Thoughts").observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            let arrayOfThoughts = snapshot.children.allObjects
            ThoughtsController.sharedInstance.thoughts = (arrayOfThoughts.map{Thoughts.init(snapshot: $0 as! FDataSnapshot)
                })
            completion()
            
        })
    }
    
    
}
