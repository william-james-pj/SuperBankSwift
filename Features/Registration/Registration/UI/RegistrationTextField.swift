//
//  RegistrationTextField.swift
//  Registration
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common

class RegistrationTextField: UITextField {
    // MARK: - Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.setupTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupTextField() {
        self.font = UIFont.systemFont(ofSize: 14)
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.backgroundColor = UIColor(named: "Disabled")
        self.setLeftPaddingPoints(16)
        self.setRightPaddingPoints(16)
    }
}

