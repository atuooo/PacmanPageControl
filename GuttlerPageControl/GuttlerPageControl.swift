//
//  GuttlerPageControl.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/23/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

public class GuttlerPageControl: UIView {
    
    public var bindScrollView : UIScrollView!
    
    // bubble
    private var bubbleLayer : BubblesLayer!
    private let bubbleSize  = Int(7)
    private var bubbleGap   = Int(17)
    
    // snake
    private var indicatorSize = Int(16)
    private var indicatorColor = UIColor()
    private var indicator      : IndicatorLayer!
    
    // page Control
    private var pageSize     : CGFloat!
    private var numOfPages   = Int()
    private var currentIndex = 0
    private var lastIndex    = 0
    
    // 防止 scrollWithScrollView(_:) 与 scrollToIndex(_:) 冲突
    private var isMoved = false
    private var isAuto  = false
    
    // MARK: - init
    
    public init(center: CGPoint, pages: Int) {
        numOfPages = pages
        let rect = CGRect(origin: CGPointZero, size: CGSize(width: (bubbleGap * (numOfPages-1) + indicatorSize), height: indicatorSize))
        super.init(frame: rect)
        self.center = center
        
        self.layer.masksToBounds = true
        
        #if swift(>=2.2)
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
            let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        #else
            let tap = UITapGestureRecognizer(target: self, action: "didTap:")
            let pan = UIPanGestureRecognizer(target: self, action: "didPan:")
        #endif
        
        self.addGestureRecognizer(tap)
        self.addGestureRecognizer(pan)
    }
    
    override public func willMoveToSuperview(newSuperview: UIView?) {
        assert(bindScrollView != nil, "You should bind the pageControl with scroll view.")
        pageSize = bindScrollView.contentSize.width / CGFloat(numOfPages)
        setSublayers()
    }
    
    private func setSublayers() {
        bubbleLayer = BubblesLayer(bubbles: numOfPages)
        bubbleLayer.size = bubbleSize
        bubbleLayer.bubbleGap = bubbleGap
        bubbleLayer.indicatorSize = indicatorSize
        bubbleLayer.frame = CGRect(origin: CGPointZero, size: frame.size)
        bubbleLayer.setNeedsDisplay()
        self.layer.addSublayer(bubbleLayer)
        
        indicator = IndicatorLayer(size: indicatorSize, color: bubbleLayer.colors[currentIndex])
        indicator.frame = CGRect(origin: CGPointZero, size: CGSize(width: indicatorSize, height: indicatorSize))
        indicator.setNeedsDisplay()
        self.layer.addSublayer(indicator)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Gesture
    
    func didTap(ges: UITapGestureRecognizer) {
        let location = ges.locationInView(self)
        if CGRectContainsPoint(self.bounds, location) {
            let index = Int(location.x) / bubbleGap
            
            if index != currentIndex {
                isAuto = true
                scrollToIndex(index)
                bindScrollView.setContentOffset(CGPoint(x: pageSize*CGFloat(index), y: 0), animated: true)
            }
        }
    }
    
    func didPan(ges: UIPanGestureRecognizer) {
        let location = ges.locationInView(self)
        if CGRectContainsPoint(self.bounds, location) {
            let index = Int(location.x) / bubbleGap
            
            if index != currentIndex {
                isAuto = true
                scrollToIndex(index)
                bindScrollView.setContentOffset(CGPoint(x: pageSize*CGFloat(index), y: 0), animated: true)
            }
        }
    }
    
    // MARK: - Scroll
    private func scrollToIndex(index: Int) {
        bubbleLayer.indicatorIndex = index
        lastIndex = currentIndex
        currentIndex = index
        indicatorColor = bubbleLayer.colors[index]
        
        if indicator.direction == .right && currentIndex < lastIndex {
            indicator.direction = .left
        }
        if indicator.direction == .left && currentIndex > lastIndex {
            indicator.direction = .right
        }
        
        indicator.position = CGPoint(x: index * bubbleGap + indicatorSize/2, y: indicatorSize/2)
        indicator.color = indicatorColor
    }
    
    public func scrollWithScrollView(scrollView: UIScrollView) {
        if scrollView.tracking == true && scrollView.dragging == true {
            isAuto = false
        }
        
        if scrollView.tracking == false && !isAuto {
            let offset = scrollView.contentOffset.x / pageSize - CGFloat(currentIndex)
            
            if offset > 0.5 || offset < -0.5 && isMoved == false {
                let index = currentIndex + Int(2 * offset)
                currentIndex = min(numOfPages-1, max(index, 0))
                bubbleLayer.indicatorIndex = currentIndex
                indicatorColor = bubbleLayer.colors[currentIndex]
                
                if indicator.direction == .left && offset > 0.5 {
                    indicator.direction = .right
                }
                if indicator.direction == .right && offset < 0.5 {
                    indicator.direction = .left
                }
                
                indicator.position = CGPoint(x: currentIndex * bubbleGap + indicatorSize/2, y: indicatorSize/2)
                indicator.color = bubbleLayer.colors[currentIndex]
                isMoved = true
            }
        } else {
            isMoved = false
        }
    }
}

