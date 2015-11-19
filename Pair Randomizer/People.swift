//
//  People.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData

@objc(People)
class People: NSManagedObject {

    
// Insert code here to add functionality to your managed object subclass
    
    convenience init(name: String = "", imageId: String = "", context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext){
        
        let entity = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.imageId = imageId
        
    }

}
