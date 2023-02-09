//
//  PasswordButton.swift
//  Login
//
//  Created by Pinto Junior, William James on 01/12/22.
//

import UIKit

class PasswordButton: UIButton {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
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

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        var config = self.getConfig()

        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("A ou B", attributes: container)

        self.configuration = config
    }

    private func getConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        config.baseForegroundColor = UIColor(named: "Primary")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .medium
        config.cornerStyle = .small
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        return config
    }
}
