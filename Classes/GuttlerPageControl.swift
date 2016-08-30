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
    private var indicator      : IndicatorLayer!
    private var indicatorSize = Int(16)
    private var indicatorColor = UIColor()
    
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
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: (bubbleGap * (pages-1) + indicatorSize), height: indicatorSize)))
        numOfPages = pages
        self.center = center
        
        layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        
        addGestureRecognizer(tap)
        addGestureRecognizer(pan)
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        assert(bindScrollView != nil, "You should bind the pageControl with scroll view.")
        pageSize = bindScrollView.contentSize.width / CGFloat(numOfPages)
        setSublayers()
    }
    
    private func setSublayers() {
        bubbleLayer = BubblesLayer(bubbles: numOfPages)
        bubbleLayer.size = bubbleSize
        bubbleLayer.bubbleGap = bubbleGap
        bubbleLayer.indicatorSize = indicatorSize
        bubbleLayer.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        bubbleLayer.setNeedsDisplay()
        layer.addSublayer(bubbleLayer)
        
        indicator = IndicatorLayer(size: indicatorSize, color: bubbleLayer.colors[currentIndex])
        indicator.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: indicatorSize, height: indicatorSize))
        indicator.setNeedsDisplay()
        layer.addSublayer(indicator)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Gesture
    
    func didTap(_ ges: UITapGestureRecognizer) {
        let location = ges.location(in: self)
        if bounds.contains(location) {
            let index = Int(location.x) / bubbleGap
            
            if index != currentIndex {
                isAuto = true
                scrollToIndex(index)
                bindScrollView.setContentOffset(CGPoint(x: pageSize*CGFloat(index), y: 0), animated: true)
            }
        }
    }
    
    func didPan(_ ges: UIPanGestureRecognizer) {
        let location = ges.location(in: self)
        if bounds.contains(location) {
            let index = Int(location.x) / bubbleGap
            
            if index != currentIndex {
                isAuto = true
                scrollToIndex(index)
                bindScrollView.setContentOffset(CGPoint(x: pageSize*CGFloat(index), y: 0), animated: true)
            }
        }
    }
    
    // MARK: - Scroll
    private func scrollToIndex(_ index: Int) {
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
    
    public func scrollWithScrollView(_ scrollView: UIScrollView) {
        if scrollView.isTracking == true && scrollView.isDragging == true {
            isAuto = false
        }
        
        if scrollView.isTracking == false && !isAuto {
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

