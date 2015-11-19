//
//  HomeScreenViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenViewController: UIViewController {

    
    @IBOutlet weak var mainTitleOutlet: UILabel!
    @IBOutlet weak var leftPictureImageView: UIImageView!
    @IBOutlet weak var rightPictureImageView: UIImageView!
    @IBOutlet weak var instructionsOutlet: UILabel!
    @IBOutlet weak var matchingOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var peopleArrayCount: Int = PeopleController.sharedController.persons.count
    var otherArrayCount: Int = OtherController.sharedController.others.count
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        deleteCoreData()
        
        OtherController.sharedController.setUpDefaultImages()
        PeopleController.sharedController.setUpDefaultImages()
        
        addMockPeople(PeopleController.sharedController.defaultPersons)
        addMockOthers(OtherController.sharedController.defaultOthers)
      
    }
    
 
    @IBAction func buttonTapped(sender: UIButton) {
    
        print("random button tapped")
        
        let randomPair = RandomizerController().randomPair(peopleArrayCount, array2Count: otherArrayCount)
        
        print("The random pair match is")
        print(randomPair.indexInArray1)
        print(randomPair.indexInArray2)
        
        print("in other words, \(PeopleController.sharedController.persons[randomPair.indexInArray1].name)")
        print("and")
        print("\(OtherController.sharedController.others[randomPair.indexInArray2].name)")
        print("match up")
        
        instructionsOutlet.text = "Nice! Looks like \(PeopleController.sharedController.persons[randomPair.indexInArray1].name!)"
        
        matchingOutlet.text = "matched up with \(OtherController.sharedController.others[randomPair.indexInArray2].name!)"
        
        if PeopleController.sharedController.persons[randomPair.indexInArray1].imageId != nil {
            ImageController.imageForImageId(PeopleController.sharedController.persons[randomPair.indexInArray1].imageId!, completion: { (image) -> Void in
                self.leftPictureImageView.image = image
            })}
        
        if OtherController.sharedController.others[randomPair.indexInArray2].imageId != nil {
            ImageController.imageForImageId(OtherController.sharedController.others[randomPair.indexInArray2].imageId!, completion: { (image) -> Void in
                self.rightPictureImageView.image = image
            })}
        
        //RandomizerController().randomForIndividual(25)
    
    }
    
    func addMockPeople(array: [People]){
        
        let array = array
        
        for people in array{
            
            PeopleController.sharedController.addPerson(people)
            
        }
    }
    
    func addMockOthers(array: [Other]){
        
        let array = array
        
        for other in array{
            
            OtherController.sharedController.addOther(other)
            
        }
    }
    
    func deleteCoreData() {
        
        let classObjectsToBeDeleted = ["People", "Other"]
        
        for thing in classObjectsToBeDeleted {
            let fetchRequest = NSFetchRequest(entityName: thing)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do { try Stack.sharedStack.managedObjectContext.executeRequest(deleteRequest)
            } catch _ as NSError {
                print("error deleting batch")
                return
            }
        }
    }
    

        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
