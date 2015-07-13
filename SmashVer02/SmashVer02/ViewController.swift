//
//  ViewController.swift
//  SmashVer02
//
//  Created by Satoshi Nakagawa on 2015/07/13.
//  Copyright (c) 2015年 nakasen.com. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var target: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var spaceWidth: CGFloat = 0
    var spaceHeight: CGFloat = 0
    
    var soundID: SystemSoundID = 0
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        spaceHeight = self.view.bounds.height
        spaceWidth = self.view.bounds.width
        
        let soundURL = NSBundle.mainBundle().URLForResource("sound", withExtension: "wav")
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        
        NSTimer.scheduledTimerWithTimeInterval(
            0.7,
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
    
    func move(){
        let x = arc4random_uniform(UInt32(self.spaceWidth))
        let y = arc4random_uniform(UInt32(self.spaceHeight))
        UIView.animateWithDuration(
            0.2,
            animations: {
                self.target.center = CGPointMake(CGFloat(x), CGFloat(y))
            }
        )
    }
    
    func displayScore(score: Int) {
        if score < 0 {
            scoreLabel.textColor = UIColor.redColor()
        } else {
            scoreLabel.textColor = UIColor.whiteColor()
        }
        scoreLabel.text = NSString(format: "%04d", abs(score)) as String
    }

    @IBAction func smash() {
        score += 2
        displayScore(score)
        AudioServicesPlayAlertSound(soundID)
    }
    
    @IBAction func fail() {
        score -= 1
        displayScore(score)
    }
}

