//
//  OtherController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OtherController: NSObject {
    
    private let OtherKey = "other"
    
    static let sharedController = OtherController()
    
    var imagePlaceholder1 = UIImage(named: "blackCar")
    var imagePlaceholder2 = UIImage(named: "greenCar")
    var imagePlaceholder3 = UIImage(named: "caddy")
    var imagePlaceholder4 = UIImage(named: "convertible")
    var imagePlaceholder5 = UIImage(named: "truck")
    
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
    
    
    var defaultOthers: [Other] {
        
        let other1 = Other(name: "Sports Car", imageId: imageId1!,  context: Stack.sharedStack.managedObjectContext)
        let other2 = Other(name: "Mustang", imageId: imageId2!, context: Stack.sharedStack.managedObjectContext)
        let other3 = Other(name: "Caddy", imageId: imageId3!, context: Stack.sharedStack.managedObjectContext)
        let other4 = Other(name: "Convertible", imageId: imageId4!, context: Stack.sharedStack.managedObjectContext)
        let other5 = Other(name: "Truck", imageId: imageId5!, context: Stack.sharedStack.managedObjectContext)
        
        return [other1, other2, other3, other4, other5]
        
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
    
    func removeOther(other: Other) {
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