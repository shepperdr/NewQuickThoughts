//
//  JournalController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

public let journalsUpdateNotification = "journalsUpdateNotification"

class JournalController {
    
    private let journalKey = "journal"
    
    static let sharedInstance = JournalController()
    
    var journals:[Journal] {
        
        didSet {
            
        }
        
    }
    
    init() {
        self.journals = []
        self.loadJournal()
        
    }
    
    func removeJournal(journal: Journal) {
        
        journal.ref?.removeValue()
        if let index = self.journals.indexOf(journal) {
            self.journals.removeAtIndex(index)
        }
    }
    
    func updateJournalTitle(journal: Journal) {
      //i need an update function to work with the "Edit" in the JournalVC
            journal.ref?.setValue("title")
//        let journalName = FirebaseController.journalNameRef
    }
    
    func loadJournal() {
        
        let journalRef = FirebaseController.journalBase
        journalRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            if let journalDict = snapshot.value as? [Dictionary<String, AnyObject>] {
                self.journals = journalDict.map({Journal(dictionary: $0)!})
                
            }
        })
        
    }
    
    func postJournalToThought(journal:Journal, thought:Thoughts, completion:(success:Bool) -> Void) {
        
        let specificThoughtRef = "\(thought.ref)"
        
        let specificThoughtID = specificThoughtRef.substringWithRange(Range<String.Index>(start: specificThoughtRef.startIndex.advancedBy(54), end: specificThoughtRef.endIndex.advancedBy(-1)))
        
        
        let thoughtRef = FirebaseController.journalBase.childByAppendingPath(specificThoughtID).childByAppendingPath("Thoughts").childByAutoId()
        thoughtRef.setValue(thought.dictionaryCopy()) { (error, firebase) -> Void in
            
            if error != nil {
                
                print(error.localizedDescription)
                completion(success: false)
                
            } else {
                
                print(firebase)
                completion(success: true)
            }
            
        }
        
        
        
    }
}
