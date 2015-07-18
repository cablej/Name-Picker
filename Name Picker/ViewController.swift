//
//  ViewController.swift
//  Name Picker
//
//  Created by Jack Cable on 7/2/15.
//  Copyright © 2015 Jack Cable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let names = ["Hollis", "Hank", "Zina", "Kira", "Ferdinand", "Susanne", "Vanita", "Bobbi", "Julia", "Brinda", "Ronald", "Shantell", "Shin", "Sanda", "Alec", "Lorelei", "Dulce", "Catina", "Janeth", "John", "Keila"]
    
    let NUM_ROWS = 7
    let NUM_COLUMNS = 3
    
    var INTERVAL = 0.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nameLabels: [UILabel] = []
        
        var row = 0
        var column = 0
        
        for name in names {
            let label = UILabel(frame: CGRectMake(0, 0, 200, 30))
            
            let x = UIScreen.mainScreen().bounds.width * (CGFloat(column) / CGFloat(NUM_COLUMNS)) + 50
            let y = UIScreen.mainScreen().bounds.height * (CGFloat(row) / CGFloat(NUM_ROWS)) + 45
            
            label.center = CGPointMake(x, y)
            label.textAlignment = NSTextAlignment.Center
            label.text = name
            self.view.addSubview(label)
            nameLabels.append(label)
            
            if(column == NUM_COLUMNS - 1) {
                column = 0
                row++
            } else {
                column++
            }
        }
        
        let shuffled = nameLabels.shuffle()
        
        let labels = dropLast(shuffled)
        
        var time = 1.0
        
        for(var i=0; i<labels.count; i++) {
            
            let label = labels[i]
            
            NSTimer.scheduledTimerWithTimeInterval(Double(time), target: self, selector: Selector("removeLabel:"), userInfo: [label], repeats: false)
            time += INTERVAL
            INTERVAL += 0.08
        }
        
    }
    
    func removeLabel(timer: NSTimer) {
        let label = timer.userInfo![0]
        label.removeFromSuperview()
    }
    
    
    
}

extension CollectionType where Index == Int {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

