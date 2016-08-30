//
//  IndicatorLayer.swift
//  GuttlerPageControl
//
//  Created by Atuooo on 3/23/16.
//  Copyright © 2016 oOatuo. All rights reserved.
//

import UIKit

enum IndicatorDirection {
    case right
    case left
}

class IndicatorLayer: CALayer {
    
    var size: Int!
    var direction = IndicatorDirection.right
    
    var color: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var angel = 1/6 * M_PI
    private let inset = 2
    
    init(size: Int, color: UIColor) {
        super.init()
        self.size = size - inset * 2
        self.color = color
        
        contentsScale = UIScreen.main.scale
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
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
        ctx.setShouldAntialias(true)
        ctx.setAllowsAntialiasing(true)
        
        ctx.beginPath()
        ctx.addArc(centerX: point.x, y: point.y, radius: CGFloat(size/2), startAngle: startAngle, endAngle: endAngle, clockwise: 0)
        ctx.addLineTo(x: mouthX, y: point.y)
        ctx.closePath()
        
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(1.2)
        ctx.setFillColor(color.cgColor)
        ctx.drawPath(using: .fillStroke)
        ctx.fillPath()
        
        // draw eye
        ctx.beginPath()
        ctx.addEllipse(inRect: eyeRect)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
    }
}
