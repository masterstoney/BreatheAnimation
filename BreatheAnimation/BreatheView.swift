//
//  BreatheView.swift
//  BreatheAnimation
//
//  Created by Tendaishe Gwini on 3/22/20.
//  Copyright © 2020 Tendaishe Gwini. All rights reserved.
//

import UIKit

class BreatheView: UIView {

    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(radius: CGFloat, circleCount: Int = 4) {
        self.init()
        self.breatheLayer = BreatheLayer(radius: radius, circleCount: circleCount)
        setupView()
    }
    
    override func layoutSubviews() {
        breatheLayer.frame = self.bounds
    }
    
    //MARK: Properties
    
    var breatheLayer: BreatheLayer!
    
    //MARK: Methods
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6941176471, blue: 0.3647058824, alpha: 1)
        layer.addSublayer(breatheLayer)
        layer.cornerRadius = 10.0
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3.0
    }
    
}
