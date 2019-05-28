//
//  Game1Controller.swift
//  StatisBox
//
//  Created by iSal on 23/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

class Game1Controller: UIViewController {

    @IBOutlet weak var rect: UIView!
    var done = false
    var delegate: ActionProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rect.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(inMove)))
        
        let swipe =  UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc  func onSwipe(_ sender: UISwipeGestureRecognizer) -> Void  {
        let direction  = sender.direction
        
        if direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
        }
        else if direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
        }
        else if direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
        }
        else if direction == UISwipeGestureRecognizer.Direction.down {
            self.dismiss(animated: true, completion: {self.removeFromParent()})
        }
    }
    
    @objc func inMove(sender:UIPanGestureRecognizer){
        if !done {
            let translation = sender.translation(in: self.view)
            let impact = UIImpactFeedbackGenerator()
            
            let x = self.rect.center.x
            let y = self.rect.center.y
            
            let target = CGPoint(x: 304.0, y: 536.25)
            
            if x>=target.x-5  && x<=target.x+5 {
                if y>=target.y-5  && y<=target.y+5{
                    self.rect.center = target
                    self.delegate?.game1IsDone()
                    impact.impactOccurred()
                    Sound.play(file: "checklist.mp3")
                    
                    self.done = true
                }
            }
            self.rect.center = CGPoint(x:self.rect.center.x + translation.x,
                                       y: self.rect.center.y + translation.y)
            
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }


}
