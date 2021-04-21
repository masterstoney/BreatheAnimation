//
//  BreatheLayer.swift
//  BreatheAnimation
//
//  Created by Tendaishe Gwini on 4/2/20.
//  Copyright © 2020 Tendaishe Gwini. All rights reserved.
//

import UIKit

class BreatheLayer: CALayer {
    
    override init() {
        super.init()
        self.addSublayer(replicatorLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(radius: CGFloat, circleCount: Int = 4) {
        self.init()
        self.radius = radius
        self.circleCount = circleCount
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        setupCircles()
    }
    
    //MARK: Properties
    
    private var radius: CGFloat = 0.0
    private var circleCount: Int = 0 {
        didSet {
            setupCircles()
        }
    }
    
    private var circleLayer: CAShapeLayer = {
        let circle = CAShapeLayer()
        circle.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.4211793664)
        return circle
    }()
    
    private lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.addSublayer(circleLayer)
        return replicatorLayer
    }()
    
    private var animationDuration: Double = 0.5
    
    private var radiusFactor: CGFloat = 1.6
    
    var rotationAnimationD: Double = 4.0
    
    //MARK: Methods
    
    private func setupCircles() {
        
        //Instantly add a new circle
        CATransaction.begin()
        CATransaction.setAnimationDuration(0)
        replicatorLayer.instanceCount = circleCount
        circleLayer.frame = CGRect(x: bounds.midX - (radius * radiusFactor), y: bounds.midY - (radius * radiusFactor), width: radius * 2, height: radius * 2)
        circleLayer.cornerRadius = radius
        CATransaction.commit()
        
        //Animate the rotation when a new circle is added
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        let angle: CGFloat = (-CGFloat.pi * 2) / CGFloat(circleCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.frame = self.bounds
        CATransaction.commit()
        
    }
    
    
    func circleCountChanged(count: Int) {
        self.circleCount = count
    }
    
    func breatheAnimation() {

        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = circleLayer.position
        animation.toValue = CGPoint(x: circleLayer.position.x + radius/2, y: circleLayer.position.y + radius/2)
        animation.duration = 1.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.autoreverses = true
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation]
        animationGroup.duration = 2.0
        animationGroup.repeatCount = 4.0
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        circleLayer.add(animationGroup, forKey: "breatheAnimation")
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = rotationAnimationD
        rotationAnimation.repeatCount = 2.0
        replicatorLayer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
    }
}
