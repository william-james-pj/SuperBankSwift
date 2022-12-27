//
//  ButtonPrimary.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit
import Common

class ButtonPrimary: UIButton {
    // MARK: - Variable
    private var textAux: String = ""
    
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
    func settingTitle(_ title: String) {
        var config = self.getConfig()
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString(title, attributes: container)
        
        self.configuration = config
    }
    
    func settingDisabled(_ isDisabled: Bool, text: String) {
        if isDisabled {
            self.configuration?.baseForegroundColor = .gray
            self.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.configuration?.attributedTitle = getButtonAttributedString(text)
            self.isEnabled = false
            return
        }
        self.configuration?.baseForegroundColor = UIColor(named: "White")
        self.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.configuration?.attributedTitle = getButtonAttributedString(text)
        self.isEnabled = true
    }
    
    func settingLoading(_ isLoading: Bool) {
        if isLoading {
            self.textAux = self.configuration?.title ?? ""
            self.isEnabled = false
            self.configuration?.attributedTitle = getButtonAttributedString("")
            self.configuration?.showsActivityIndicator = true
            return
        }
        self.isEnabled = true
        self.configuration?.attributedTitle = getButtonAttributedString(self.textAux)
        self.configuration?.showsActivityIndicator = false
    }
    
    private func setupButton() {
        self.configuration = self.getConfig()
    }
    
    private func getConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .large
        return config
    }
    
    private func getButtonAttributedString(_ text: String) -> AttributedString {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 16, weight: .bold)
        return AttributedString(text, attributes: container)
    }
}
