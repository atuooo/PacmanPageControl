//
//  ViewController.swift
//  PacmanPageControl-Demo
//
//  Created by ooatuoo on 2017/3/25.
//  Copyright © 2017年 ooatuoo. All rights reserved.
//

import UIKit

let pageCount = 7

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var pacman2: PacmanPageControl = {
        let pacmanFrame = CGRect(x: 0, y: view.frame.midY + 20, width: view.frame.width, height: 20)
        let pacman = PacmanPageControl(frame: pacmanFrame)
        pacman.scrollView = scrollView
        pacman.dotColorStyle = .same(.cyan)
        pacman.pacmanColorStyle = .fixed(.orange)
        return pacman
    }()
    
    lazy var pacman3: PacmanPageControl = {
        let pacmanFrame = CGRect(x: 0, y: view.frame.midY + 50, width: view.frame.width, height: 20)
        let pacman = PacmanPageControl(frame: pacmanFrame)
        pacman.scrollView = scrollView
        pacman.dotDiameter = 10
        pacman.pacmanDiameter = 20
        pacman.dotColorStyle = .random(hue: .random, luminosity: .light)
        pacman.pacmanColorStyle = .changeWithEatenDot
        return pacman
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set scrollView
        do {
            scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(pageCount), height: scrollView.frame.height)
            
            for i in 0 ..< pageCount {
                let subview = UIView(frame: CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height))
                subview.backgroundColor = randomColor(hue: .blue, luminosity: .bright)
                scrollView.addSubview(subview)
            }
        }
        
        // add pac-man
        view.addSubview(pacman2)
        view.addSubview(pacman3)
    }
}


