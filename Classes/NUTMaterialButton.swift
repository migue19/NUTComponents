//
//  NUTMaterialButton.swift
//  NUTComponents
//
//  Created by Miguel Mexicano Herrera on 03/11/25.
//

import UIKit

@IBDesignable
open class NUTMaterialButton: UIButton {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable public var elevation: CGFloat = 2.0 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 4.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var rippleColor: UIColor = UIColor(white: 1.0, alpha: 0.3) {
        didSet {
            rippleLayer.fillColor = rippleColor.cgColor
        }
    }
    
    @IBInspectable public var backgroundLayerColor: UIColor = UIColor.systemBlue {
        didSet {
            backgroundLayer.backgroundColor = backgroundLayerColor.cgColor
        }
    }
    
    @IBInspectable public var enableRipple: Bool = true
    
    // MARK: - Private Properties
    
    private var backgroundLayer: CALayer = CALayer()
    private var rippleLayer: CAShapeLayer = CAShapeLayer()
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Setup
    
    private func setupButton() {
        // Setup background layer
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = cornerRadius
        backgroundLayer.backgroundColor = backgroundLayerColor.cgColor
        layer.insertSublayer(backgroundLayer, at: 0)
        
        // Setup ripple layer
        rippleLayer.fillColor = rippleColor.cgColor
        rippleLayer.opacity = 0
        layer.insertSublayer(rippleLayer, above: backgroundLayer)
        
        // Setup shadow
        updateShadow()
        
        // Remove default background
        backgroundColor = .clear
        
        // Adjust title color
        if titleColor(for: .normal) == nil {
            setTitleColor(.white, for: .normal)
        }
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
    
    // MARK: - Shadow
    
    private func updateShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: elevation)
        layer.shadowRadius = elevation
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
    
    // MARK: - Touch Handling
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if enableRipple, let touch = touches.first {
            let location = touch.location(in: self)
            animateRipple(at: location)
        }
        
        // Animate press
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.layer.shadowOffset = CGSize(width: 0, height: self.elevation / 2)
            self.layer.shadowRadius = self.elevation / 2
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        resetButton()
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        resetButton()
    }
    
    // MARK: - Animations
    
    private func animateRipple(at point: CGPoint) {
        let maxRadius = max(bounds.width, bounds.height) * 1.5
        let ripplePath = UIBezierPath(arcCenter: point, radius: maxRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        rippleLayer.path = ripplePath.cgPath
        rippleLayer.opacity = 1.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 0.4
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 0.4
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.duration = 0.4
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = true
        
        rippleLayer.add(groupAnimation, forKey: "ripple")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.rippleLayer.opacity = 0
        }
    }
    
    private func resetButton() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.updateShadow()
        }
    }
    
    // MARK: - Public Methods
    
    /// Set elevation with animation
    public func setElevation(_ elevation: CGFloat, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.elevation = elevation
            }
        } else {
            self.elevation = elevation
        }
    }
}
