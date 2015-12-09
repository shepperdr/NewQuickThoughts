//
//  ThoughtsController.swift
//  NewQuickThoughts
//
//  Created by Robert Shepperd on 12/1/15.
//  Copyright © 2015 Robert Shepperd. All rights reserved.
//

import Foundation
import Firebase

public let thoughtsUpdateNotification = "thoughtsUpdateNotification"

class ThoughtsController {
    
    private let thoughtsKey = "thoughts"
    
    static let sharedInstance = ThoughtsController()
    
    var thoughts:[Thoughts] {
        
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(thoughtsUpdateNotification, object: self)
            
        }
        
    }
    
    init() {
        self.thoughts = []
        self.loadThoughts()
        
    }
    
    func removeThoughts(thought: Thoughts) {
        
        thought.ref?.removeValue()
    }
    
    
    
    func loadThoughts() {
        
        let thoughtsRef = FirebaseController.journalBase.childByAppendingPath("Thought")
        thoughtsRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            if let thoughtDict = snapshot.value as? [Dictionary<String, AnyObject>] {
                self.thoughts = thoughtDict.map({Thoughts(dictionary: $0)!})
                
            }
        })
        
    }
    
    func postThoughtToJournal(journal:Journal, thought:Thoughts, completion:(success:Bool) -> Void) {
        
        let specificJournalRef = "\(journal.ref)"
        
        let specificJournalUID = specificJournalRef.substringWithRange(Range<String.Index>(start: specificJournalRef.startIndex.advancedBy(54), end: specificJournalRef.endIndex.advancedBy(-1)))
        
        
        let journalRef = FirebaseController.journalBase.childByAppendingPath(specificJournalUID).childByAppendingPath("Thoughts").childByAutoId()
        journalRef.setValue(thought.dictionaryCopy()) { (error, firebase) -> Void in
            
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