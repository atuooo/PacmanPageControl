//
//  ViewController.swift
//  PacmanPageControl-Demo
//
//  Created by ooatuoo on 2017/3/25.
//  Copyright © 2017年 ooatuoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let pageCount = 7
    
    var pacman1: PacmanPageControl!
    var pacman2: PacmanPageControl!
    var pacman3: PacmanPageControl!
    
    lazy var scrollView: UIScrollView = {
        let pageSize = self.view.frame.width
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: pageSize, height: self.view.frame.height))
        scrollView.contentSize = CGSize(width: pageSize * CGFloat(self.pageCount), height: scrollView.frame.height)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self
        
        for i in 0 ..< pageCount {
            let subview = UIView(frame: CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height))
            subview.backgroundColor = randomColor(hue: .blue, luminosity: .bright)
            scrollView.addSubview(subview)
        }
        
        view.addSubview(scrollView)
        
        var pacmanFrame = CGRect(x: 0, y: view.frame.height - 200, width: view.frame.width, height: 20)
        
        // default
        pacman1 = PacmanPageControl(frame: pacmanFrame, pageCount: pageCount)
        view.addSubview(pacman1)
        
        // custom
        pacmanFrame.origin.y += 22
        
        pacman2 = PacmanPageControl(frame: pacmanFrame, pageCount: pageCount)
        pacman2.dotColorStyle = .same(.cyan)    
        pacman2.pacmanColorStyle = .fixed(.orange)
        
        view.addSubview(pacman2)
        
        // custom
        pacmanFrame.origin.y += 30
        
        pacman3 = PacmanPageControl(frame: pacmanFrame, pageCount: pageCount)
        pacman3.dotDiameter = 10
        pacman3.pacmanDiameter = 20
//        pacman3.dotColorStyle = .different([.purple, .orange, .cyan, .magenta])
        pacman3.dotColorStyle = .random(hue: .orange, luminosity: .light)
        pacman3.pacmanColorStyle = .changeWithDot
        view.addSubview(pacman3)
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pacman1.scroll(with: scrollView)
        pacman2.scroll(with: scrollView)
        pacman3.scroll(with: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pacman1.lastContentOffsetX = scrollView.contentOffset.x
        pacman2.lastContentOffsetX = scrollView.contentOffset.x
        pacman3.lastContentOffsetX = scrollView.contentOffset.x
    }
}

