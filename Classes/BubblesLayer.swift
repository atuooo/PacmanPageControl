//
//  BubblesLayer.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/23/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

class BubblesLayer: CALayer {
    
    var size = 0
    var bubbleGap = 0
    var indicatorSize = 0
    var colors = [UIColor]()
    
    private var count = 0
    
    var indicatorIndex = 0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    init(bubbles: Int) {
        super.init()
        count = bubbles
        colors = Array(repeating: randomColor(hue: .purple, luminosity: .light), count: count)
        
        contentsScale = UIScreen.main.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        
        for i in 0 ..< count {
            
            if i != indicatorIndex {
                
                let bubbleRect = CGRect(x: (indicatorSize-size)/2 + i * bubbleGap, y: Int(bounds.midY)-size/2, width: size, height: size)
                
                let color = randomColor(hue: .random, luminosity: .light)
                colors[i] = color
                ctx.setFillColor(color.cgColor)
                ctx.fillEllipse(in: bubbleRect)
            }
        }
    }
}

