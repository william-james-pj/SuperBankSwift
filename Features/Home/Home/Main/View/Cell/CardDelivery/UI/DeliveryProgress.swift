//
//  DeliveryProgress.swift
//  Home
//
//  Created by Pinto Junior, William James on 19/12/22.
//

import UIKit
import Common

class DeliveryProgress: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    private let viewBall1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewBall2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewBall3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingView(_ status: ECardDeliveryStatusType) {
        self.resetColors()
        
        switch status {
        case .production:
            self.setFirstStatus()
        case .delivery:
            self.setSecondStatus()
        case .delivered:
            self.setThirdStatus()
        }
    }
    
    private func resetColors() {
        self.viewBall1.backgroundColor = UIColor(named: "DisabledLight")
        self.viewLine1.backgroundColor = UIColor(named: "DisabledLight")
        self.viewBall2.backgroundColor = UIColor(named: "DisabledLight")
        self.viewLine2.backgroundColor = UIColor(named: "DisabledLight")
        self.viewBall3.backgroundColor = UIColor(named: "DisabledLight")
    }
    
    private func setFirstStatus() {
        self.viewBall1.backgroundColor = UIColor(named: "Primary")
    }
    
    private func setSecondStatus() {
        self.setFirstStatus()
        
        self.viewLine1.backgroundColor = UIColor(named: "Primary")
        self.viewBall2.backgroundColor = UIColor(named: "Primary")
    }
    
    private func setThirdStatus() {
        self.setSecondStatus()
        
        self.viewLine2.backgroundColor = UIColor(named: "Primary")
        self.viewBall3.backgroundColor = UIColor(named: "Primary")
    }
    
    private func buildHierarchy() {
        self.addSubview(viewBall1)
        self.addSubview(viewLine1)
        self.addSubview(viewBall2)
        self.addSubview(viewLine2)
        self.addSubview(viewBall3)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 15),
            
            viewBall1.widthAnchor.constraint(equalToConstant: 10),
            viewBall1.heightAnchor.constraint(equalToConstant: 10),
            viewBall1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewBall1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            viewLine1.widthAnchor.constraint(equalToConstant: 60),
            viewLine1.heightAnchor.constraint(equalToConstant: 2),
            viewLine1.leadingAnchor.constraint(equalTo: viewBall1.trailingAnchor),
            viewLine1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            viewBall2.widthAnchor.constraint(equalToConstant: 10),
            viewBall2.heightAnchor.constraint(equalToConstant: 10),
            viewBall2.leadingAnchor.constraint(equalTo: viewLine1.trailingAnchor),
            viewBall2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            viewLine2.widthAnchor.constraint(equalToConstant: 60),
            viewLine2.heightAnchor.constraint(equalToConstant: 2),
            viewLine2.leadingAnchor.constraint(equalTo: viewBall2.trailingAnchor),
            viewLine2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            viewBall3.widthAnchor.constraint(equalToConstant: 10),
            viewBall3.heightAnchor.constraint(equalToConstant: 10),
            viewBall3.leadingAnchor.constraint(equalTo: viewLine2.trailingAnchor),
            viewBall3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
