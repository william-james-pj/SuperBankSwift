//
//  PasswordButtons.swift
//  Login
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

protocol PasswordButtonsDelegate: AnyObject {
    func getPasswordCharacter(_ character: ButtonPasswordText)
    func removeLastTypedPassword()
}

class PasswordButtons: UIView {
    // MARK: - Variables
    private var buttonsTexts: [ButtonPasswordText]?
    weak var delegate: PasswordButtonsDelegate?

    // MARK: - Components
    private let stackRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stackColumn1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stackColumn2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var button1: PasswordButton = {
        let button = PasswordButton()
        button.tag = 0
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var button2: PasswordButton = {
        let button = PasswordButton()
        button.tag = 1
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var button3: PasswordButton = {
        let button = PasswordButton()
        button.tag = 2
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var button4: PasswordButton = {
        let button = PasswordButton()
        button.tag = 3
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var button5: PasswordButton = {
        let button = PasswordButton()
        button.tag = 4
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var button6: PasswordButton = {
        let button = PasswordButton()
        button.tag = 5
        button.settingImage()
        button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return button
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

    // MARK: - Actions
    @IBAction private func passwordButtonTapped(_ sender: UIButton) {
        guard let buttonsTexts = self.buttonsTexts else {
            return
        }
        if buttonsTexts.count < sender.tag {
            return
        }
        let character = buttonsTexts[sender.tag]
        self.delegate?.getPasswordCharacter(character)
    }

    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        self.delegate?.removeLastTypedPassword()
    }

    // MARK: - Methods
    func settingTitles(_ texts: [ButtonPasswordText]) {
        self.buttonsTexts = texts
        self.button1.settingText(texts[0])
        self.button2.settingText(texts[1])
        self.button3.settingText(texts[2])
        self.button4.settingText(texts[3])
        self.button5.settingText(texts[4])
    }

    func settingButtons(_ isDisable: Bool) {
        if isDisable {
            self.button1.isEnabled = false
            self.button2.isEnabled = false
            self.button3.isEnabled = false
            self.button4.isEnabled = false
            self.button5.isEnabled = false
            return
        }

        self.button1.isEnabled = true
        self.button2.isEnabled = true
        self.button3.isEnabled = true
        self.button4.isEnabled = true
        self.button5.isEnabled = true
    }

    private func buildHierarchy() {
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

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackRow.topAnchor.constraint(equalTo: self.topAnchor),
            stackRow.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackRow.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackRow.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
