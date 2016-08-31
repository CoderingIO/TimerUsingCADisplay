//
//  ViewController.swift
//  Timer
//
//  Created by Wayne Bangert on 8/30/16.
//  Copyright © 2016 Wayne Bangert. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController {
    
    @IBOutlet weak var nummericDisplay: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!

    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default raw values
        self.nummericDisplay.text = "0.000000000000"
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        
        // Initializing the display link and directing it to call our displayLinkUpdate: method when an update is available
        self.displayLink = CADisplayLink(target: self, selector: #selector(ViewController.displayLinkUpdate(_:)))
        
        // ensure that the display link is initially not updating
        self.displayLink.paused = true;
        
        // Scheduling the display link to send notifications
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        // initial time stamps
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
    }

    @IBAction func resetButtonPressed(sender: AnyObject) {
        
        // pause display link updates
        self.displayLink.paused = true
        
        //set default numeric display value
        self.nummericDisplay.text = "0.00"
        
        // set button to start state
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        
        //reset running tally
        self.lastDisplayLinkTimeStamp = 0.0
    }
    
    @IBAction func startStopButtonPressed(sender: AnyObject) {
        
        // set display link on or off
        self.displayLink.paused = !(self.displayLink.paused)
    
        
        var buttonText:String = "Stop"
        if self.displayLink.paused {
            if self.lastDisplayLinkTimeStamp > 0 {
                buttonText = "Resume"
            } else {
                buttonText = "Start"
            }
        }
        
        self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
        
    }

    func displayLinkUpdate(sender: CADisplayLink) {
        
        // update counter
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        
        // format tally
        let formattedString:String = String(format: "%0.8f", self.lastDisplayLinkTimeStamp)
        
        // Display tally
        self.nummericDisplay.text = formattedString
        print(formattedString)
    }
}

