//
//  Game2Controller.swift
//  StatisBox
//
//  Created by iSal on 23/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//
import Foundation
import UIKit
import CoreMotion

class Game2Controller: UIViewController {

    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    @IBOutlet weak var circle4: UIView!
    
    lazy var circles: [UIView] = [circle1,circle2,circle3,circle4]
    let impact = UIImpactFeedbackGenerator()
    var done:[Bool] = [false,false,false,false]
    var constPosition:[CGFloat] = [0,0,0,0]
    var delegate: ActionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (idx,circle) in circles.enumerated() {
            let const:CGFloat = .random(in: -2...2)
            self.constPosition[idx] = const
            circle.transform = CGAffineTransform(rotationAngle: const)
        }
        
        let swipe =  UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        let  rotate1 = UIRotationGestureRecognizer(target: self, action: #selector(onRotate1))
        self.circle1.addGestureRecognizer(rotate1)
        
        let  rotate2 = UIRotationGestureRecognizer(target: self, action: #selector(onRotate2))
        self.circle2.addGestureRecognizer(rotate2)
        
        let  rotate3 = UIRotationGestureRecognizer(target: self, action: #selector(onRotate3))
        self.circle3.addGestureRecognizer(rotate3)
        
        let  rotate4 = UIRotationGestureRecognizer(target: self, action: #selector(onRotate4))
        self.circle4.addGestureRecognizer(rotate4)
    }
    
    @objc func onRotate1(sender:UIRotationGestureRecognizer){
        if !done[0] {
            self.circle1.transform = self.circle1.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            if self.circle1.rotation >= -0.05 && self.circle1.rotation <= 0.05{
                self.circle1.transform.b = 0
                self.circle1.transform.c = 0
                impact.impactOccurred()
                Sound.play(file: "checklist.mp3")
                
                self.done[0] = true
            }
        }
    }
    
    @objc func onRotate2(sender:UIRotationGestureRecognizer){
        if !done[1] {
            self.circle2.transform = self.circle2.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            if self.circle2.rotation >= -0.05 && self.circle2.rotation <= 0.05{
                self.circle2.transform.b = 0
                self.circle2.transform.c = 0
                impact.impactOccurred()
                Sound.play(file: "checklist.mp3")
                
                self.done[1] = true
            }
        }
    }
    
    @objc func onRotate3(sender:UIRotationGestureRecognizer){
        if !done[2] {
            self.circle3.transform = self.circle3.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            if self.circle3.rotation >= -0.05 && self.circle3.rotation <= 0.05{
                self.circle3.transform.b = 0
                self.circle3.transform.c = 0
                impact.impactOccurred()
                Sound.play(file: "checklist.mp3")
                
                self.done[2] = true
            }
        }
    }
    
    @objc func onRotate4(sender:UIRotationGestureRecognizer){
        if !done[3] {
            self.circle4.transform = self.circle4.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            if self.circle4.rotation >= -0.05 && self.circle4.rotation <= 0.05{
                self.circle4.transform.b = 0
                self.circle4.transform.c = 0
                impact.impactOccurred()
                Sound.play(file: "checklist.mp3")
                
                self.done[3] = true
            }
        }
    }
    
    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) -> Void  {
        let direction  = sender.direction
        if self.done[0] && self.done[1] && self.done[2] && self.done[3] {
            self.delegate?.game2IsDone()
        }
        if direction == UISwipeGestureRecognizer.Direction.down {
            self.dismiss(animated: true, completion: {self.removeFromParent()})
        }
    }
}
