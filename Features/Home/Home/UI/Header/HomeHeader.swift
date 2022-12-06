//
//  HomeHeader.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

protocol HomeHeaderDelegate {
    func openDrawerMenu()
}

class HomeHeader: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    var delegate: HomeHeaderDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackUser: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewUserBoxContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonUser: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "Text")
        config.baseBackgroundColor = UIColor(named: "Card")
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(DrawerButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackUserInfo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelHello: UILabel = {
        let label = UILabel()
        label.text = "Olá,"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewEyeContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonEye: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewBellContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonBell: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupVC() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Actions
    @IBAction private func DrawerButtonTapped(_ sender: UIButton) {
        self.delegate?.openDrawerMenu()
    }
    
    // MARK: - Methods
    func settingView(fullName: String) {
        var nameArr = fullName.components(separatedBy: " ")
        self.labelName.text = "\(nameArr[0]) \(nameArr[1])"
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 12, weight: .bold)
        self.buttonUser.configuration?.attributedTitle = AttributedString(
            String(nameArr[0].remove(at: nameArr[0].startIndex)),
            attributes: container
        )
    }
    
    private func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackUser)
        stackUser.addArrangedSubview(viewUserBoxContainer)
        viewUserBoxContainer.addSubview(buttonUser)
        stackUser.addArrangedSubview(stackUserInfo)
        stackUserInfo.addArrangedSubview(labelHello)
        stackUserInfo.addArrangedSubview(labelName)
        
        stackBase.addArrangedSubview(stackButtons)
        stackButtons.addArrangedSubview(viewEyeContainer)
        viewEyeContainer.addSubview(buttonEye)
        stackButtons.addArrangedSubview(viewBellContainer)
        viewBellContainer.addSubview(buttonBell)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewUserBoxContainer.widthAnchor.constraint(equalToConstant: 28),
            buttonUser.widthAnchor.constraint(equalToConstant: 35),
            buttonUser.heightAnchor.constraint(equalToConstant: 35),
            buttonUser.centerXAnchor.constraint(equalTo: viewUserBoxContainer.centerXAnchor),
            buttonUser.centerYAnchor.constraint(equalTo: viewUserBoxContainer.centerYAnchor),
            
            viewEyeContainer.widthAnchor.constraint(equalToConstant: 20),
            buttonEye.widthAnchor.constraint(equalToConstant: 20),
            buttonEye.heightAnchor.constraint(equalToConstant: 15),
            buttonEye.centerXAnchor.constraint(equalTo: viewEyeContainer.centerXAnchor),
            buttonEye.centerYAnchor.constraint(equalTo: viewEyeContainer.centerYAnchor),
            
            viewBellContainer.widthAnchor.constraint(equalToConstant: 17),
            buttonBell.widthAnchor.constraint(equalToConstant: 17),
            buttonBell.heightAnchor.constraint(equalToConstant: 19),
            buttonBell.centerXAnchor.constraint(equalTo: viewBellContainer.centerXAnchor),
            buttonBell.centerYAnchor.constraint(equalTo: viewBellContainer.centerYAnchor),
        ])
    }
}
