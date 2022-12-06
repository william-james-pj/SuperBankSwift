//
//  BalanceCollectionViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class BalanceCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "BalanceCollectionViewCell"
    
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Saldo"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFildeMoney: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "Text")
        textField.text = "* * *"
        textField.font = .systemFont(ofSize: 16)
        textField.isEnabled = false
        textField.isSecureTextEntry = true
        textField.isEnabled = false
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell(_ value: String, isHide: Bool) {
        self.labelValue.text = "R$ " + value
        
        if isHide {
            self.textFildeMoney.isHidden = false
            self.labelValue.isHidden = true
            return
        }
        
        self.textFildeMoney.isHidden = true
        self.labelValue.isHidden = false
    }
    
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(labelValue)
        stackBase.addArrangedSubview(textFildeMoney)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}


