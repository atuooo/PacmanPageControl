//
//  PacmanPageControl.swift
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

@IBDesignable
open class PacmanPageControl: UIView {
    public enum DotColorStyle {
        case same(UIColor)
        case different([UIColor])
        case random(hue: Hue, luminosity: Luminosity)
    }
    
    public enum PacmanColorStyle {
        case fixed(UIColor)
        case changeWithEatenDot
    }

    open var dotColorStyle:    DotColorStyle = .random(hue: .random, luminosity: .light)
    open var pacmanColorStyle: PacmanColorStyle = .changeWithEatenDot
    
    @IBInspectable open var pacmanDiameter:  CGFloat = 12
    @IBInspectable open var dotDiameter:     CGFloat = 5
    @IBInspectable open var dotInterval:     CGFloat = 0
    
    @IBOutlet open var scrollView: UIScrollView? {
        didSet {
            guard oldValue !== scrollView else { return }
            
            [#keyPath(UIScrollView.contentOffset)].forEach {
                oldValue?.removeObserver(self, forKeyPath: $0)
                scrollView?.addObserver(self, forKeyPath: $0, options: [.new, .old, .initial], context: nil)
            }
            
            if let newSV = scrollView {
                pageCount = lroundf(Float(newSV.contentSize.width / newSV.frame.width))
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == #keyPath(UIScrollView.contentOffset), let scrlView = scrollView else { return }
        scroll(with: scrlView)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        isUserInteractionEnabled = false
        setDotColors()
        setSubLayers()
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
    
    #if TARGET_INTERFACE_BUILDER
        public override func draw(_ rect: CGRect) {
            setSubLayers()
        }

        public override func prepareForInterfaceBuilder() {
            pageCount = 6
        }
    #endif
    
    // MARK: - Private
    
    private var pageCount: Int = 0 {
        didSet {
            guard oldValue != pageCount, superview != nil else { return }
            setDotColors()
            setSubLayers()
        }
    }
    
    private var progress: CGFloat = 0
    private var pacmanOriginX: CGFloat = 0
    private var lastContentOffsetX: CGFloat = 0
    
    private var dotColors: [UIColor] = []
    private var dotLayers: [CAShapeLayer] = []
    
    private lazy var pacmanLayer: PacmanLayer = {
        return PacmanLayer()
    }()
    
    private func scroll(with scrollView: UIScrollView) {
        let svOffsetX = scrollView.contentOffset.x
        let svWidth = scrollView.frame.width
        progress = svOffsetX / svWidth
        
        let checkCount = lroundf(Float(scrollView.contentSize.width / svWidth))
        guard checkCount == pageCount, checkCount > 0 else { return pageCount = checkCount }
        
        if lastContentOffsetX < svOffsetX {
            pacmanLayer.direction = .right
        } else if lastContentOffsetX > svOffsetX {
            pacmanLayer.direction = .left
        }
        
        let offset = abs(fmodf(Float(svOffsetX), Float(svWidth)))
        let factor = max(0, CGFloat(offset)/svWidth)
        
        if factor == 0 {
            lastContentOffsetX = svOffsetX
            
            if case .changeWithEatenDot = pacmanColorStyle {
                pacmanLayer.color = dotColors[Int(progress)]
            }
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pacmanLayer.position.x = pacmanOriginX + pacmanDiameter / 2 + progress * (dotDiameter + dotInterval)
        CATransaction.commit()
        
        pacmanLayer.factor = CGFloat(factor)
        
        for (index, layer) in dotLayers.enumerated() {
            setDotLayer(layer, at: index)
        }
    }
    
    private func setDotColors() {
        guard pageCount != 0 else { return dotColors.removeAll() }
        
        switch dotColorStyle {
        case .same(let color):
            dotColors = Array(repeating: color, count: pageCount)
            
        case .different(let colors):
            if colors.isEmpty {
                let defaultColor = UIColor(red: 0.94, green: 0.72, blue: 0.3, alpha: 1)
                dotColors = Array.init(repeating: defaultColor, count: pageCount)
                
            } else {
                (0 ..< (pageCount / colors.count)).forEach { _ in
                    dotColors.append(contentsOf: colors)
                }
                
                dotColors.append(contentsOf: colors.prefix(pageCount % colors.count))
            }

        case .random(let hue, let luminosity):
            dotColors = randomColors(count: pageCount, hue: hue, luminosity: luminosity)
        }
    }

    private func setSubLayers() {
        dotLayers.forEach { $0.removeFromSuperlayer() }
        pacmanLayer.removeFromSuperlayer()

        guard pageCount != 0 else { return }
        
        if dotInterval <= 0 {
            dotInterval = dotDiameter * 1.2
        }
        
        let dotTotalWidth = dotDiameter * CGFloat(pageCount) + dotInterval * CGFloat(pageCount - 1)
        let dotOriginY = (frame.height - dotDiameter) / 2
        let dotOriginX = (frame.width - dotTotalWidth) / 2
        pacmanOriginX = dotOriginX + dotDiameter / 2 - pacmanDiameter / 2
        
        var dotFrame = CGRect(x: dotOriginX, y: dotOriginY, width: dotDiameter, height: dotDiameter)
        
        dotLayers = (0..<pageCount).map { index in
            let dot = CAShapeLayer()
            dot.frame = dotFrame
            dot.fillColor = dotColors[index].cgColor
            dotFrame.origin.x += dotDiameter + dotInterval
            
            setDotLayer(dot, at: index)
            layer.addSublayer(dot)
            return dot
        }
        
        let oriX = pacmanOriginX  + progress * (dotDiameter + dotInterval)
        pacmanLayer.frame = CGRect(x: oriX, y: (frame.height - pacmanDiameter) / 2, width: pacmanDiameter, height: pacmanDiameter)
        pacmanLayer.contentsScale = UIScreen.main.scale
        
        if case let .fixed(color) = pacmanColorStyle {
            pacmanLayer.color = color
        } else {
            pacmanLayer.color = dotColors[min(0, Int(progress))]
        }
        
        layer.addSublayer(pacmanLayer)
        pacmanLayer.setNeedsDisplay()
    }
    
    private func setDotLayer(_ dotLayer: CAShapeLayer, at index: Int) {
        guard progress >= 0 && progress <= CGFloat(pageCount - 1) else { return }
        
        let originRect = CGRect(x: 0, y: 0, width: dotDiameter, height: dotDiameter)
        
        let offset = abs(progress - CGFloat(index))
        let x = min(1, offset)
        let insetDis = dotDiameter / 2 * (x * x - 2 * x + 1)
        
        let scaleRect = originRect.insetBy(dx: insetDis, dy: insetDis)
        dotLayer.path = UIBezierPath(ovalIn: scaleRect).cgPath
    }
}
