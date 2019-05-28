//
//  Game4Controller.swift
//  StatisBox
//
//  Created by iSal on 25/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

protocol SwitchProtocol {
    func doSwitch()
}

class Game4Controller: UIViewController, SwitchProtocol {

    static var poinA:Int?
    static var poinB:Int?
    
    lazy var colorSet:[UIColor] = [
        UIColor(hex: "#A973C1"),
        UIColor(hex: "#8C45AC"),
        UIColor(hex: "#6F1697"),
        UIColor(hex: "#4E0F6A"),
        UIColor(hex: "#380B4C")
    ]
    
    var delegate: ActionProtocol?
    var stackView:UIStackView = UIStackView()
    
    @IBAction func tapp(_ sender: Any) {
        let impact = UIImpactFeedbackGenerator()
        
        let colorSet:[UIColor] = [
            UIColor(hex: "#A973C1"),
            UIColor(hex: "#8C45AC"),
            UIColor(hex: "#6F1697"),
            UIColor(hex: "#4E0F6A"),
            UIColor(hex: "#380B4C")
        ]
        
        for (i,color)  in colorSet.enumerated(){
            let view = self.stackView.arrangedSubviews[i]
            let rect:Rect = Rect(frame: CGRect(x: 0, y: 0, width: 100, height: 100), color: color, index: i)
            rect.delegate = self
            
            self.stackView.removeArrangedSubview(view)
            self.stackView.insertArrangedSubview(rect, at: i)
        }
        impact.impactOccurred()
        self.checkOrder()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipe =  UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        self.stackView = self.configureStackView()
        self.view.addSubview(self.stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,constant: -100).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    
    fileprivate func configureStackView() -> UIStackView{
        colorSet.shuffle()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        
        for (i,color)  in colorSet.enumerated(){
            let rect:Rect = Rect(frame: CGRect(x: 0, y: 0, width: 100, height: 100), color: color, index: i)
            rect.delegate = self
            stackView.addArrangedSubview(rect)
        }
        return stackView
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
    
    func iterateColor(colors:[UIColor]) {
        var i = 0
        var solve = true
        while (i<=4 && solve==true) {
            if !self.stackView.arrangedSubviews[i].backgroundColor!.isEqual(colors[i]) {
                solve=false
            }
            i +=  1
        }
        
        if solve==true {
            Sound.play(file: "checklist.mp3")
            self.delegate?.game4IsDone()
        }
    }
    
    func checkOrder(){
        var colorSet:[UIColor] = [
            UIColor(hex: "#A973C1"),
            UIColor(hex: "#8C45AC"),
            UIColor(hex: "#6F1697"),
            UIColor(hex: "#4E0F6A"),
            UIColor(hex: "#380B4C")
        ]
        self.iterateColor(colors: colorSet)
        
        colorSet.reverse()
        self.iterateColor(colors: colorSet)
    }
    
    func doSwitch(){
        let impact = UIImpactFeedbackGenerator()
        
        print("switching")
        let view1 = self.stackView.arrangedSubviews[Game4Controller.poinA!] as! Rect
        let view2 = self.stackView.arrangedSubviews[Game4Controller.poinB!] as! Rect
        
        self.stackView.removeArrangedSubview(view1)
        self.stackView.insertArrangedSubview(view1, at: Game4Controller.poinB!)
        
        self.stackView.removeArrangedSubview(view2)
        self.stackView.insertArrangedSubview(view2, at: Game4Controller.poinA!)
        
        view1.index = Game4Controller.poinB
        view2.index = Game4Controller.poinA
        
        Game4Controller.poinA = nil
        Game4Controller.poinB = nil
        
        impact.impactOccurred()
        self.checkOrder()
        
    }
    
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
