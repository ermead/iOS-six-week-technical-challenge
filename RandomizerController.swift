//
//  RandomizerController.swift
//  Pair Randomizer
//
//  Created by Eric Mead on 11/18/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import UIKit

class RandomizerController {
    
    init(){
        
        
    }
    
    var arrayCount1: Int = 0
    var arrayCount2: Int = 0
    
    func randomPair(array1Count: Int, array2Count: Int)->(indexInArray1: Int, indexInArray2: Int) {
        
        var pair : (Int, Int) = (0,0)
        
        var randomArray1 : Int = Int(arc4random_uniform(UInt32(array1Count - 1)))
        
        var randomArray2 : Int = Int(arc4random_uniform(UInt32(array2Count - 1)))
        
        
        pair = (randomArray1, randomArray2)
        
        print("For the random pair between two collections of \(array1Count) things and \(array2Count) things, the randomly selected pair is located at the index, \(randomArray1) of the first collection and \(randomArray2) in the second collection, respectively.")
        
        return pair
    }
    
    func randomForIndividual(arrayCount: Int) -> (Int){
        
        
        var randomIndex : Int = Int(arc4random_uniform(UInt32(arrayCount - 1)))
        
        print("For the random collection of \(arrayCount) things, the randomly selected thing is located at the index, \(randomIndex).")
        
        return randomIndex
    }
    
    
}
