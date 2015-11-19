//
//  PeopleController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PeopleController: NSObject {
    
    private let PeopleKey = "people"
    
    static let sharedController = PeopleController()
    
    var imagePlaceholder1 = UIImage(named: "randomPerson1")
    var imagePlaceholder2 = UIImage(named: "randomPerson2")
    var imagePlaceholder3 = UIImage(named: "randomPerson3")
    var imagePlaceholder4 = UIImage(named: "randomPerson4")
    var imagePlaceholder5 = UIImage(named: "randomPerson5")
    
    var imageId1: String? = "12345"
    var imageId2: String? = "12345"
    var imageId3: String? = "12345"
    var imageId4: String? = "12345"
    var imageId5: String? = "12345"
    
    func setUpDefaultImages(){
        
        ImageController.getImageIdFromPhoto(self.imagePlaceholder1!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.imageId1 = imageId
            }
        }
        ImageController.getImageIdFromPhoto(self.imagePlaceholder2!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.imageId2 = imageId
            }
        }
        ImageController.getImageIdFromPhoto(self.imagePlaceholder3!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.imageId3 = imageId
            }
        }
        ImageController.getImageIdFromPhoto(self.imagePlaceholder4!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.imageId4 = imageId
            }
        }
        ImageController.getImageIdFromPhoto(self.imagePlaceholder5!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.imageId5 = imageId
            }
        }
    }

    
    var defaultPersons: [People] {
        
        let person1 = People(name: "Jane", imageId: self.imageId1!, context: Stack.sharedStack.managedObjectContext)
        let person2 = People(name: "Frank", imageId: self.imageId2!, context: Stack.sharedStack.managedObjectContext)
        let person3 = People(name: "Bob", imageId: self.imageId3!, context: Stack.sharedStack.managedObjectContext)
        let person4 = People(name: "Sarah", imageId: self.imageId4!, context: Stack.sharedStack.managedObjectContext)
        let person5 = People(name: "Joe", imageId: self.imageId5!, context: Stack.sharedStack.managedObjectContext)
        
        return [person1, person2, person3, person4, person5]
        
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