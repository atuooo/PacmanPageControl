//
//  ViewController.swift
//  GuttlerPageControlDemo
//
//  Created by Atuooo on 3/25/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit
import RandomColorSwift

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
        scrollView.pagingEnabled = true
        scrollView.bounces = true
        scrollView.delegate = self
        
        for i in 0..<numOfpage {
            let subview = UIView(frame: CGRect(x: pageSize * CGFloat(i), y: 0, width: pageSize, height: scrollView.frame.height))
            subview.backgroundColor = randomColor(hue: .Blue, luminosity: .Bright)
            scrollView.addSubview(subview)
        }
        
        view.addSubview(scrollView)
        
        guttlerPageControl = GuttlerPageControl(center: CGPoint(x: view.center.x, y: view.center.y+130), pages: numOfpage)
        guttlerPageControl.bindScrollView = scrollView
        view.addSubview(guttlerPageControl)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guttlerPageControl.scrollWithScrollView(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

