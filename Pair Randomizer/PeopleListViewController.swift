//
//  PeopleListViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import CoreData

class PeopleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!

    var placeholderImageId: String = " "
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imagePlaceholder: UIImageView!

    @IBOutlet weak var namePlaceholder: UILabel!
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        print("add a new person")
        
        let newAlert = UIAlertController(title: "Add New Person", message: "add a name and photo", preferredStyle: .Alert)
        
        newAlert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "name"
        }
        
        newAlert.addAction(UIAlertAction(title: "Add Photo", style: .Default, handler: { (action) -> Void in
            
            if let textfields = newAlert.textFields{
                self.namePlaceholder.text = textfields[0].text!
            }
            
            self.addPhoto()
            self.saveButton.hidden = false
        }))
        
        newAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(newAlert, animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.hidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(sender: UIButton) {
    
        ImageController.getImageIdFromPhoto(self.imagePlaceholder.image!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.placeholderImageId = imageId
            }
        }
        
        PeopleController.sharedController.addPerson(People(name: self.namePlaceholder.text!, imageId: self.placeholderImageId, context: Stack.sharedStack.managedObjectContext))
        
        tableView.reloadData()
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = PeopleController.sharedController.persons[indexPath.row].name
        
        if PeopleController.sharedController.persons[indexPath.row].imageId != nil {
            ImageController.imageForImageId(PeopleController.sharedController.persons[indexPath.row].imageId!, completion: { (image) -> Void in
                cell.imageView?.image = image
            })}
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return PeopleController.sharedController.persons.count
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let person = PeopleController.sharedController.persons[indexPath.row]
            PeopleController.sharedController.removePerson(person)
                    tableView.reloadData()
        }
    
    }
    
    
    func addPhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let photoChoiceAlert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            photoChoiceAlert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            photoChoiceAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
            
        }
        
        photoChoiceAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(photoChoiceAlert, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        self.imagePlaceholder.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
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
