//
//  HomeScreenViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import CoreData
import CoreGraphics
import AVFoundation

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var synthesizeButton: UIButton!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var mainTitleOutlet: UILabel!
    @IBOutlet weak var leftPictureImageView: UIImageView!
    @IBOutlet weak var rightPictureImageView: UIImageView!
    @IBOutlet weak var instructionsOutlet: UILabel!
    @IBOutlet weak var matchingOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var peopleArrayCount: Int?
    var otherArrayCount: Int?
    var faceBounds: CGRect?
    var randomGreetings: [String] = ["Yes", "Cool", "Right On", "Wow", "Nice", "Super", "That makes sense"]
    var randomMatchExpressions: [String] = ["paired up", "matched up", "is compatible", "fits best", "fits together", "got paired"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        //deleteCoreData()
        
      
    }
    
    func setUp(){
        peopleArrayCount = PeopleController.sharedController.persons.count
        otherArrayCount = OtherController.sharedController.others.count
        buttonOutlet.layer.cornerRadius = 10
        buttonOutlet.layer.borderColor = UIColor.blackColor().CGColor
        buttonOutlet.layer.borderWidth = 2
        synthesizeButton.layer.cornerRadius = 10
        synthesizeButton.layer.borderColor = UIColor.blueColor().CGColor
        synthesizeButton.layer.borderWidth = 2
    }
 
    @IBAction func buttonTapped(sender: UIButton) {
    
        print("random button tapped")
        
        let thisGreeting = RandomizerController().randomExclamation(self.randomGreetings)
        let thisMatchedExpression = RandomizerController().randomExclamation(self.randomMatchExpressions)
        var randomPair = RandomizerController().randomPair(peopleArrayCount!, array2Count: otherArrayCount!)
        
        print("The random pair match is")
        print(randomPair.indexInArray1)
        print(randomPair.indexInArray2)
        
        print("in other words, \(PeopleController.sharedController.persons[randomPair.indexInArray1].name)")
        print("and")
        print("\(OtherController.sharedController.others[randomPair.indexInArray2].name)")
        print("match up")
        
        let randomArray: [String] = []
        
        instructionsOutlet.text = "\(thisGreeting)! Looks like \(PeopleController.sharedController.persons[randomPair.indexInArray1].name!)"
        
        matchingOutlet.text = "\(thisMatchedExpression) with a \(OtherController.sharedController.others[randomPair.indexInArray2].name!)"
        
        if PeopleController.sharedController.persons[randomPair.indexInArray1].imageId != nil {
            ImageController.imageForImageId(PeopleController.sharedController.persons[randomPair.indexInArray1].imageId!, completion: { (image) -> Void in
                self.leftPictureImageView.image = image
            })}
        
        if OtherController.sharedController.others[randomPair.indexInArray2].imageId != nil {
            ImageController.imageForImageId(OtherController.sharedController.others[randomPair.indexInArray2].imageId!, completion: { (image) -> Void in
                self.rightPictureImageView.image = image
            })}
        
        self.detectFaces()
        
        var  utterance1 = AVSpeechUtterance(string: self.instructionsOutlet.text!)
        var  utterance2 = AVSpeechUtterance(string: self.matchingOutlet.text!)
        utterance1.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance1.rate = 0.51
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance2.rate = 0.51
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance1)
        synthesizer.speakUtterance(utterance2)
        
        
        
        //RandomizerController().randomForIndividual(25)
    
    }
    
    @IBAction func synthesizeButtonTapped(sender: UIButton) {
        
        if sender.titleLabel?.text == "close"{
         
            resultImage.image = nil
            synthesizeButton.setTitle("Synthesize!", forState: .Normal)
            
        } else {
            applyFilter()
            synthesizeButton.setTitle("close", forState: .Normal)
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
    
    func detectFaces(){
        
        if let inputImage = leftPictureImageView.image {
            let ciImage = CIImage(CGImage: inputImage.CGImage!)
            
            let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
            
            let faces = faceDetector.featuresInImage(ciImage)
            
            if let face = faces.first as? CIFaceFeature {
                print("Found face at \(face.bounds)")
                self.faceBounds = face.bounds
                
                if face.hasLeftEyePosition {
                    print("Found left eye at \(face.leftEyePosition)")
                }
                
                if face.hasRightEyePosition {
                    print("Found right eye at \(face.rightEyePosition)")
                }
                
                if face.hasMouthPosition {
                    print("Found mouth at \(face.mouthPosition)")
                }
            }
        }
    }
    
    func applyFilter(){
        
        if let personImage = leftPictureImageView.image, otherImage = rightPictureImageView.image {
            let rect = CGRect(x: 0, y: 0, width: personImage.size.width, height: personImage.size.height)
           
            
            UIGraphicsBeginImageContextWithOptions(personImage.size, true, 0)
            let context = UIGraphicsGetCurrentContext()
            
            // fill the background with white so that translucent colors get lighter
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextFillRect(context, rect)
            
            personImage.drawInRect(rect, blendMode: .Normal, alpha: 1)
            //img6.drawInRect(rect, blendMode: .Luminosity, alpha: 1)
            //img6.drawInRect(rect, blendMode: .Mutiply, alpha: 1)
            //img6.drawInRect(rect, blendMode: .Screen, alpha: 1)
            otherImage.drawInRect(rect, blendMode: CGBlendMode.Overlay, alpha: 0.7)
            
            // grab the finished image and return it
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            
            self.resultImage.image = result
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
