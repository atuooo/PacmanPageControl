//
//  ViewController.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/25/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var guttlerPageControl: GuttlerPageControl!
    let numOfpage = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageSize = view.frame.width
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: pageSize, height: 300))
        scrollView.contentSize = CGSize(width: pageSize * CGFloat(numOfpage), height: scrollView.frame.height)
        scrollView.center = view.center
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.delegate = self
        
        for i in 0..<numOfpage {
            let subview = UIView(frame: CGRect(x: pageSize * CGFloat(i), y: 0, width: pageSize, height: scrollView.frame.height))
            subview.backgroundColor = randomColor(hue: .blue, luminosity: .bright)
            scrollView.addSubview(subview)
        }
        
        view.addSubview(scrollView)
        
        // Just init with position and numOfpage
        guttlerPageControl = GuttlerPageControl(center: CGPoint(x: view.center.x, y: view.center.y+130), pages: numOfpage)
        // Must bind pageControl with the scrollView
        guttlerPageControl.bindScrollView = scrollView
        view.addSubview(guttlerPageControl)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Just invoke scrollWithScrollView(_:) in scrollViewDidScroll(_:)
        guttlerPageControl.scrollWithScrollView(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
