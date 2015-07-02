//
//  ViewController.swift
//  SmashSwift
//
//  Created by Satoshi Nakagawa on 2015/07/02.
//  Copyright (c) 2015年 nakasen.com. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var target: UIButton!
    
    var spaceWidth:CGFloat = 0
    var spaceHeight:CGFloat = 0
    
    var soundID: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        spaceHeight = self.view.bounds.height
        spaceWidth = self.view.bounds.width
        
        let soundURL = NSBundle.mainBundle().URLForResource("sound", withExtension:"wav")
        AudioServicesCreateSystemSoundID(soundURL, &soundID);
        
        NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: "move",
            userInfo: nil,
            repeats: true
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func smash() {
        AudioServicesPlaySystemSound(soundID)
    }
    
    func move() {
        let x = arc4random_uniform(UInt32(self.spaceWidth))
        let y = arc4random_uniform(UInt32(self.spaceHeight))
        UIView.animateWithDuration(0.7, animations: {
            self.target.center = CGPointMake(CGFloat(x), CGFloat(y))
        })
    }
}

