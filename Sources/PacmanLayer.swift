//
//  PacmanLayer.swift
//  PacmanPageControl
//
//  Copyright (c) 2017 oOatuo (aaatuooo@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
        
        let currentAngle = direction == .right ? theAngle : theAngle - CGFloat.pi
        
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
        
        let minAngle = CGFloat(27 / 180 * CGFloat.pi)
        let maxAngle = CGFloat(49 / 180 * CGFloat.pi)
        let zeroAngle = CGFloat(3 / 180 * CGFloat.pi)
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
