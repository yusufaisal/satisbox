//
//  Game5Controller.swift
//  StatisBox
//
//  Created by iSal on 25/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

class Game5Controller: UIViewController {

    @IBOutlet weak var digit: UILabel!
    var delegate: ActionProtocol?
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    let vibration = UIVibrancyEffect()
    var done = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        digit.text = String(format: "%.1f", Float.random(in: 15...19.5) )
        
        let swipe =  UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc  func onSwipe(_ sender: UISwipeGestureRecognizer) -> Void  {
        let direction  = sender.direction
        if direction == UISwipeGestureRecognizer.Direction.down {
            self.dismiss(animated: true, completion: {self.removeFromParent()})
        }
    }
    
    @IBAction func onUP(_ sender: Any) {
        if !done {
            var num = Double(self.digit.text!)
            let duration: Double = 1.0 //seconds
            DispatchQueue.global().async {
                for _ in 0 ..< .random(in: 1...4) {
                    let sleepTime = UInt32(duration/Double(10) * 900000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        self.impact.impactOccurred()
                        
                        num = num! + 0.1
                        self.digit.text = String(format: "%.1f", num!)
                    }
                }
                
                for _ in 0...1{
                    usleep(1000)
                    DispatchQueue.main.async {
                        if String(format: "%.1f", num!)=="20.0" {
                            self.delegate?.game5IsDone()
                            self.notification.notificationOccurred(.success)
                            Sound.play(file: "checklist.mp3")
                            self.done = true
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onDOWN(_ sender: Any) {
        if !done {
            var num = Double(self.digit.text!)
            let duration: Double = 1.0 //seconds
            DispatchQueue.global().async {
                for _ in 0 ..< .random(in: 1...4) {
                    let sleepTime = UInt32(duration/Double(10) * 900000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        self.impact.impactOccurred()
                        
                        num = num! - 0.1
                        self.digit.text = String(format: "%.1f", num!)
                    }
                }
                
                for _ in 0...1{
                    usleep(1000)
                    DispatchQueue.main.async {
                        if String(format: "%.1f", num!)=="20.0" {
                            self.delegate?.game5IsDone()
                            self.notification.notificationOccurred(.success)
                            Sound.play(file: "checklist.mp3")
                            self.done = true
                        }
                    }
                    
                }
                
                
                
            }
        }
    }
}
