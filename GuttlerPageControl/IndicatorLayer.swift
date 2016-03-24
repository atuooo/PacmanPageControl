//
//  IndicatorLayer.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/23/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

import UIKit

enum IndicatorDirection {
    case right
    case left
}

class IndicatorLayer: CALayer {
    
    var size  : Int!
    var direction = IndicatorDirection.right
    
    var color : UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var angel = 1/6 * M_PI
    private let inset = 2
    
    init(size: Int, color: UIColor) {
        super.init()
        self.size = size - inset*2
        self.color = color
        
        self.contentsScale = UIScreen.mainScreen().scale
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let point = CGPoint(x: size/2 + inset, y: size/2 + inset)
        let eyeSize = CGFloat(size) / 5
        let eyeY = point.y - eyeSize - 1
        
        let startAngle, endAngle, mouthX : CGFloat, eyeRect : CGRect
        if direction == .left {
            startAngle = CGFloat(M_PI+angel)
            endAngle   = CGFloat(M_PI-angel)
            mouthX     = point.x * 0.8
            eyeRect    = CGRect(x: point.x+1, y: eyeY, width: eyeSize, height: eyeSize)
        } else {
            startAngle = CGFloat(angel)
            endAngle   = CGFloat(2 * M_PI-angel)
            mouthX     = point.x * 1.2
            eyeRect    = CGRect(x: point.x-eyeSize-1, y: eyeY, width: eyeSize, height: eyeSize)
        }
        
        // draw outline
        CGContextSetShouldAntialias(ctx, true)
        CGContextSetAllowsAntialiasing(ctx, true)
        
        CGContextBeginPath(ctx)
        CGContextAddArc(ctx, point.x, point.y, CGFloat(size/2), startAngle, endAngle, 0)
        CGContextAddLineToPoint(ctx, mouthX, point.y)
        CGContextClosePath(ctx)
        
        CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(ctx, 1.2)
        CGContextSetFillColorWithColor(ctx, color.CGColor)
        CGContextDrawPath(ctx, .FillStroke)
        CGContextFillPath(ctx)
        
        // draw eye
        CGContextBeginPath(ctx)
        CGContextAddEllipseInRect(ctx, eyeRect)
        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextFillPath(ctx)
    }
}
