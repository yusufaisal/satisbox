//
//  Rect.swift
//  StatisBox
//
//  Created by iSal on 25/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

class Rect: UIView {

    var index:Int?
    var delegate: SwitchProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame:CGRect, color:UIColor, index: Int){
        super.init(frame: frame)
        self.backgroundColor = color
        self.index = index
        
        // let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        // self.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tap)
    }

    @objc  private func onTap(sender: UITapGestureRecognizer){
        if Game4Controller.poinA == nil {
            Game4Controller.poinA = self.index
        } else {
            Game4Controller.poinB = self.index
            self.delegate?.doSwitch()
        }
    }
    
    @objc private func onPan(sender: UIPanGestureRecognizer){
        let translation  = sender.translation(in: self)
        self.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
    }
    
    func getIndex() -> Int {
        return index!
    }
}

