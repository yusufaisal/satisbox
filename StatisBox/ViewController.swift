//
//  ViewController.swift
//  StatisBox
//
//  Created by iSal on 22/05/19.
//  Copyright © 2019 iSal. All rights reserved.
//

import UIKit

protocol ActionProtocol{
    func game1IsDone()
    func game2IsDone()
    func game3IsDone()
    func game4IsDone()
    func game5IsDone()
}

class ViewController: UIViewController, ActionProtocol {
    var slides:[UIImageView]?
    let images:[String] = [
        "Game1",
        "Game2",
        "Game3",
        "Game4",
        "Game5"
    ]
    
    @IBOutlet weak var scrollView: UIScrollView!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        setupSlideScrollView(slides: slides!)
    }
    
    fileprivate func createSlides() -> [UIImageView]{
        var slides:[UIImageView] = []
        for i in 0...4{
            let view = UIImageView(frame: CGRect(
                    origin: CGPoint(x: 0, y: 0) ,
                    size:   CGSize(width: 250, height: 250))
                )
            view.image = UIImage(named: self.images[i])
            slides.append(view)
        }
        return  slides
    }
    
    fileprivate func setupSlideScrollView(slides: [UIImageView]){
        let x = self.scrollView.center.x
        let y = self.scrollView.center.y
        let width = self.scrollView.frame.width
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width * CGFloat(slides.count),
            height: self.scrollView.frame.height
        )
        for i in 0..<slides.count {
            let contentX:CGFloat = x + (width * CGFloat(i))
            slides[i].center = CGPoint(x: contentX, y: y)
            self.scrollView.addSubview(slides[i])
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        let currentPage:Int = scrollView.currentPage
        print(currentPage)
        
        if currentPage==1{
            let game1 = Game1Controller()
            game1.delegate = self
            present(game1, animated: true, completion: nil)
        } else if currentPage==2 {
            let game2 = Game2Controller()
            game2.delegate = self
            present(game2, animated: true, completion: nil)
        } else if currentPage==3 {
            let game3 = Game3Controller()
            game3.delegate = self
            present(game3, animated: true, completion: nil)
        } else if currentPage==4 {
            let game4 = Game4Controller()
            game4.delegate = self
            present(game4, animated: true, completion: nil)
        } else if currentPage==5 {
            let game5 = Game5Controller()
            game5.delegate = self
            present(game5, animated: true, completion: nil)
        }
    }
    
    func game1IsDone(){
        self.slides![0].image =  UIImage(named: "Game1Done")
    }
    func game2IsDone(){
        self.slides![1].image =  UIImage(named: "Game2Done")
    }
    func game3IsDone(){
        self.slides![2].image =  UIImage(named: "Game3Done")
    }
    func game4IsDone(){
        self.slides![3].image =  UIImage(named: "Game4Done")
    }
    func game5IsDone(){
        self.slides![4].image =  UIImage(named: "Game5Done")
    }
}

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}
