//
//  HomeHeader.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class HomeHeader: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackUser: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewUserBoxContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewUserBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Disabled")
        view.clipsToBounds = true
        view.layer.cornerRadius = 17
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelNameBox: UILabel = {
        let label = UILabel()
        label.text = "WJ"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let stackUserInfo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelHello: UILabel = {
        let label = UILabel()
        label.text = "Olá,"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.text = "William"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewEyeContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let buttonEye: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let viewBellContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let buttonBell: UIButton = {
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
    fileprivate func setupVC() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackUser)
        stackUser.addArrangedSubview(viewUserBoxContainer)
        viewUserBoxContainer.addSubview(viewUserBox)
        viewUserBox.addSubview(labelNameBox)
        stackUser.addArrangedSubview(stackUserInfo)
        stackUserInfo.addArrangedSubview(labelHello)
        stackUserInfo.addArrangedSubview(labelName)
        
        stackBase.addArrangedSubview(stackButtons)
        stackButtons.addArrangedSubview(viewEyeContainer)
        viewEyeContainer.addSubview(buttonEye)
        stackButtons.addArrangedSubview(viewBellContainer)
        viewBellContainer.addSubview(buttonBell)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewUserBoxContainer.widthAnchor.constraint(equalToConstant: 28),
            viewUserBox.widthAnchor.constraint(equalToConstant: 35),
            viewUserBox.heightAnchor.constraint(equalToConstant: 35),
            viewUserBox.centerXAnchor.constraint(equalTo: viewUserBoxContainer.centerXAnchor),
            viewUserBox.centerYAnchor.constraint(equalTo: viewUserBoxContainer.centerYAnchor),
            
            labelNameBox.centerXAnchor.constraint(equalTo: viewUserBox.centerXAnchor),
            labelNameBox.centerYAnchor.constraint(equalTo: viewUserBox.centerYAnchor),
            
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
