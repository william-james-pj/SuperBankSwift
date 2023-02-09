//
//  BalanceHomeTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit

class BalanceHomeTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "BalanceHomeTableViewCell"

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
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
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

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Setup
    private func setupView() {
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
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(labelValue)
        stackBase.addArrangedSubview(textFildeMoney)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
