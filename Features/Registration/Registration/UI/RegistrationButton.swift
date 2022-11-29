//
//  RegistrationButton.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit
import Common

class RegistrationButton: UIButton {
    // MARK: - Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupButton() {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .large
        
        
        self.configuration = config
    }
}
