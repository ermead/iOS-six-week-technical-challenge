//
//  HomeScreenViewController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var mainTitleOutlet: UILabel!
    @IBOutlet weak var leftPictureImageView: UIImageView!
    @IBOutlet weak var rightPictureImageView: UIImageView!
    @IBOutlet weak var instructionsOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RandomizerController().randomPair(8, array2Count: 16)
        RandomizerController().randomForIndividual(25)

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func buttonTapped(sender: UIButton) {
    
        print("random button tapped")
        
        RandomizerController().randomPair(8, array2Count: 16)
        RandomizerController().randomForIndividual(25)
    
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
