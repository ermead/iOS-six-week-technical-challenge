//
//  PeopleController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData

class PeopleController: NSObject {
    
    private let PeopleKey = "people"
    
    static let sharedController = PeopleController()
    
    var defaultPersons: [People] {
        
        let person1 = People(name: "John", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        let person2 = People(name: "Frank", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        let person3 = People(name: "Bob", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        
        return [person1, person2, person3]
        
    }
    
    var persons: [People] {
        
        let request = NSFetchRequest(entityName: "People")
        
        do {
            return try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [People]
            
        } catch {
            return []
        }
    }
    
    func addPerson(person: People) {
        saveToPersistentStorage()
    }
    
    func removePerson(person: People) {
        person.managedObjectContext?.deleteObject(person)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage(){
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
}