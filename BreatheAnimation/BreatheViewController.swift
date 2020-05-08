//
//  ViewController.swift
//  BreatheAnimation
//
//  Created by Tendaishe Gwini on 3/22/20.
//  Copyright © 2020 Tendaishe Gwini. All rights reserved.
//

import UIKit

class BreatheViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    
    //MARK: Properties
    
    private var breatheView: BreatheView = BreatheView(radius: 45, circleCount: 4)
    
    private var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 2
        stepper.maximumValue = 10
        stepper.value = 4
        stepper.addTarget(self, action: #selector(changeCircleCount), for: .valueChanged)
        return stepper
    }()
    
    private var triggerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Trigger", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(breathe), for: .touchUpInside)
        return button
    }()
    
    private var impactFeedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator()
    
    //MARK: Methods
    
    private func setupView() {
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        breatheView.translatesAutoresizingMaskIntoConstraints = false
        breatheView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        breatheView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        view.addSubview(breatheView)
        breatheView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        breatheView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(stepper)
        stepper.topAnchor.constraint(equalTo: breatheView.bottomAnchor, constant: 10).isActive = true
        stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stepper.heightAnchor.constraint(equalToConstant: 35).isActive = true
        stepper.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(triggerButton)
        triggerButton.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 10).isActive = true
        triggerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        triggerButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        triggerButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        impactFeedbackGenerator.prepare()
    }
    
    @objc func changeCircleCount() {
        breatheView.breatheLayer.circleCountChanged(count: Int(stepper.value))
        impactFeedbackGenerator.impactOccurred()
    }

    @objc func breathe() {
        breatheView.breatheLayer.breatheAnimation()
    }

}

