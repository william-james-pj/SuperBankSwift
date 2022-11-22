//
//  PasswordButtons.swift
//  Login
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class PasswordButtons: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    fileprivate let stackRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackColumn1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackColumn2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let button1: PasswordButton = {
        let button = PasswordButton()
        return button
    }()
    
    fileprivate let button2: PasswordButton = {
        let button = PasswordButton()
        return button
    }()
    
    fileprivate let button3: PasswordButton = {
        let button = PasswordButton()
        return button
    }()
    
    fileprivate let button4: PasswordButton = {
        let button = PasswordButton()
        return button
    }()
    
    fileprivate let button5: PasswordButton = {
        let button = PasswordButton()
        return button
    }()
    
    fileprivate let button6: PasswordButton = {
        let button = PasswordButton()
        button.settingImage()
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingTitles(_ texts: [ButtonPasswordText]) {
        self.button1.settingText(texts[0])
        self.button2.settingText(texts[1])
        self.button3.settingText(texts[2])
        self.button4.settingText(texts[3])
        self.button5.settingText(texts[4])
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackRow)
        
        stackRow.addArrangedSubview(stackColumn1)
        stackColumn1.addArrangedSubview(button1)
        stackColumn1.addArrangedSubview(button2)
        stackColumn1.addArrangedSubview(button3)
        
        stackRow.addArrangedSubview(stackColumn2)
        stackColumn2.addArrangedSubview(button4)
        stackColumn2.addArrangedSubview(button5)
        stackColumn2.addArrangedSubview(button6)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackRow.topAnchor.constraint(equalTo: self.topAnchor),
            stackRow.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackRow.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackRow.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

class PasswordButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingText(_ text: ButtonPasswordText) {
        var config = self.getConfig()
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("\(text.first) ou \(text.second)", attributes: container)
        
        self.configuration = config
    }
    
    func settingImage() {
        self.setTitle("", for: .normal)
        var config = self.getConfig()
        config.image = UIImage(systemName: "delete.left",
          withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        
        self.configuration = config
    }
    
    fileprivate func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var config = self.getConfig()
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("A ou B", attributes: container)
        
        self.configuration = config
    }
    
    fileprivate func getConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        config.baseForegroundColor = UIColor(named: "Primary")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .medium
        config.cornerStyle = .small
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        return config
    }
}
