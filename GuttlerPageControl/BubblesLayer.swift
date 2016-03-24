//
//  BubblesLayer.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/23/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

class BubblesLayer: CALayer {
    
    var size = Int()
    var bubbleGap = Int()
    var indicatorSize = Int()
    var colors : [UIColor]!
    
    private var count : Int!
    
    var indicatorIndex = 0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    init(bubbles: Int) {
        super.init()
        count = bubbles
        colors = Array(count: count, repeatedValue: randomColor(hue: .Purple, luminosity: .Light))
        
        self.contentsScale = UIScreen.mainScreen().scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {        
        for i in 0 ..< count {
            if i != indicatorIndex {
                let bubbleRect = CGRect(x: (indicatorSize-size)/2 + i * bubbleGap, y: Int(bounds.midY)-size/2, width: size, height: size)
                
                let color = randomColor(hue: .Random, luminosity: .Light)
                colors[i] = color
                CGContextSetFillColorWithColor(ctx, color.CGColor)
                CGContextFillEllipseInRect(ctx, bubbleRect)
            }
        }
    }
}

