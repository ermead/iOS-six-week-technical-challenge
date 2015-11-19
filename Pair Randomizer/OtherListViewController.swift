//
//  OtherListViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class OtherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        print("add a new other entry")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("otherCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = OtherController.sharedController.others[indexPath.row].name
        cell.imageView?.image = UIImage(named: "default")
        

        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OtherController.sharedController.others.count
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
//    @IBAction func addPhotoButtonTapped(sender: UIButton){
//        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        
//        let photoChoiceAlert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
//        
//        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
//            photoChoiceAlert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
//                imagePicker.sourceType = .PhotoLibrary
//                
//                self.presentViewController(imagePicker, animated: true, completion: nil)
//            }))
//        }
//        
//        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
//            
//            photoChoiceAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
//                imagePicker.sourceType = .Camera
//                
//                self.presentViewController(imagePicker, animated: true, completion: nil)
//            }))
//            
//        }
//        
//        photoChoiceAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//        
//        self.presentViewController(photoChoiceAlert, animated: true, completion: nil)
//        
//        
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        
//         = info[UIImagePickerControllerOriginalImage] as? UIImage
//        
//    }


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
