//
//  OtherListViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class OtherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var namePlaceholder: UILabel!
    @IBOutlet weak var imagePlaceholder: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    var placeholderImageId: String = " "
   
    @IBAction func saveButtonTapped(sender: UIButton) {
    
        ImageController.getImageIdFromPhoto(self.imagePlaceholder.image!) { (imageId) -> Void in
            
            if let imageId = imageId {
                self.placeholderImageId = imageId
            }
        }
        
        OtherController.sharedController.addOther(Other(name: self.namePlaceholder.text!, imageId: self.placeholderImageId, context: Stack.sharedStack.managedObjectContext))
        
        self.tableview.reloadData()
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        print("add a new other entry")
        
        let newAlert = UIAlertController(title: "Add New Thing", message: "add a thing's name and photo", preferredStyle: .Alert)
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("otherCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = OtherController.sharedController.others[indexPath.row].name
        cell.imageView?.image = UIImage(named: "default")
        
        if OtherController.sharedController.others[indexPath.row].imageId != nil {
            ImageController.imageForImageId(OtherController.sharedController.others[indexPath.row].imageId!, completion: { (image) -> Void in
                cell.imageView?.image = image
            })}
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OtherController.sharedController.others.count
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let other = OtherController.sharedController.others[indexPath.row]
            OtherController.sharedController.removeOther(other)
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
