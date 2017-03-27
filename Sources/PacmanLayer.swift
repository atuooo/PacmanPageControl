//
//  PacmanLayer.swift
//  PacmanPageControl-Demo
//
//  Created by ooatuoo on 2017/3/25.
//  Copyright © 2017年 ooatuoo. All rights reserved.
//

import UIKit

class PacmanLayer: CALayer {
    
    public var color: UIColor!
    public var direction: ScrollDirection = .right
    
    public var factor: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    fileprivate var diameter: CGFloat!
    fileprivate let lineWidth: CGFloat = 1.0
    fileprivate let lineColor: UIColor = .white

    enum ScrollDirection {
        case right
        case left
    }
    
    override func draw(in ctx: CGContext) {
        
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let theAngle = calculateAngle(with: factor)
        
        let currentAngle = direction == .right ? theAngle : theAngle - CGFloat(M_PI)
        
        ctx.setShouldAntialias(true)
        ctx.setAllowsAntialiasing(true)

        // draw body
        
        ctx.beginPath()
        ctx.addArc(center: center, radius: (frame.width / 2 - lineWidth), startAngle: currentAngle, endAngle: -currentAngle, clockwise: false)
        ctx.addLine(to: center)
        ctx.closePath()
        
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(lineColor.cgColor)
        ctx.setFillColor(color.cgColor)
        ctx.drawPath(using: .fillStroke)
        ctx.fillPath()
        
        // draw eye
        
        let eyeDiameter = 0.15 * frame.width
        let eyeRect = CGRect(x: (frame.width - eyeDiameter) / 2, y: frame.height / 4 - eyeDiameter / 2, width: eyeDiameter, height: eyeDiameter)
        
        ctx.beginPath()
        ctx.addEllipse(in: eyeRect)
        ctx.setFillColor(lineColor.cgColor)
        ctx.fillPath()
    }
    
    fileprivate func calculateAngle(with x: CGFloat) -> CGFloat {
        
        let minAngle = CGFloat(27 / 180 * M_PI)
        let maxAngle = CGFloat(49 / 180 * M_PI)
        let zeroAngle = CGFloat(3 / 180 * M_PI)
        let diffAngle = maxAngle - minAngle
        
        if x <= 0.5 {
            return -4 * diffAngle * x * x + 4 * diffAngle * x + minAngle
            
        } else if x <= 0.75 {
            return 4 * (zeroAngle - maxAngle) * x + 3 * maxAngle - 2 * zeroAngle
            
        } else {
            return 4 * (minAngle - zeroAngle) * x + 4 * zeroAngle - 3 * minAngle
        }
    }
}
