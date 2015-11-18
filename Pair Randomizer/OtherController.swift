//
//  OtherController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData

class OtherController: NSObject {
    
    private let OtherKey = "other"
    
    static let sharedController = OtherController()
    
    var defaultPersons: [Other] {
        
        let other1 = Other(name: "Truck", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        let other2 = Other(name: "Ferrari", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        let other3 = Other(name: "Minivan", imageId: "12345", context: Stack.sharedStack.managedObjectContext)
        
        return [other1, other2, other3]
        
    }
    
    var others: [Other] {
        
        let request = NSFetchRequest(entityName: "Other")
        
        do {
            return try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Other]
            
        } catch {
            return []
        }
    }
    
    func addOther(other: Other) {
        saveToPersistentStorage()
    }
    
    func removePerson(other: Other) {
        other.managedObjectContext?.deleteObject(other)
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