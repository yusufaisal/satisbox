//
//  Game5Controller.swift
//  statistics
//
//  Created by iSal on 21/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

class Game3Controller: UIViewController {
    
    @IBOutlet weak var target: UIView!
    var done = false
    var delegate: ActionProtocol?
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circular = UIRotationGestureRecognizer(target: self, action: #selector(onRotate))
        self.view.addGestureRecognizer(circular)
        self.target.transform = CGAffineTransform(rotationAngle: .random(in: -2...2))
        
        let swipe =  UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        print(self.target.rotation)
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
    
    @objc func onRotate(_ sender: UIRotationGestureRecognizer){
        if !done {
            self.target.transform = self.target.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            if self.target.rotation >= -0.05 && self.target.rotation <= 0.05{
                self.target.transform.b = 0
                self.target.transform.c = 0
                impact.impactOccurred()
                Sound.play(file: "checklist.mp3")

                self.done = true
                self.delegate?.game3IsDone()
            }
        }
        
    }
    
}

extension UIView {
    var rotation:Double {
        return atan2(Double(self.transform.b), Double(self.transform.a))
    }

}
