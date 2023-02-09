//
//  CreditInvoiceHomeTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit

class CreditInvoiceHomeTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "CreditInvoiceHomeTableViewCell"

    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Disabled")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Cartão de crédito"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron-right")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let stackFooter: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stackInvoice: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelInvoice: UILabel = {
        let label = UILabel()
        label.text = "Fatura atual"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelInvoiceValue: UILabel = {
        let label = UILabel()
        label.text = "R$ 0,00"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let buttonPay: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.buttonSize = .large

        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 12, weight: .bold)
        config.attributedTitle = AttributedString("Detalhes da fatura", attributes: container)

        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(viewLine)

        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(labelTitle)
        stackHeader.addArrangedSubview(viewImage)
        viewImage.addSubview(imageViewIcon)

        stackBase.addArrangedSubview(stackFooter)
        stackFooter.addArrangedSubview(stackInvoice)
        stackInvoice.addArrangedSubview(labelInvoice)
        stackInvoice.addArrangedSubview(labelInvoiceValue)
        stackFooter.addArrangedSubview(viewButtonContainer)
        viewButtonContainer.addSubview(buttonPay)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            viewLine.heightAnchor.constraint(equalToConstant: 1),

            viewImage.widthAnchor.constraint(equalToConstant: 8),
            imageViewIcon.widthAnchor.constraint(equalToConstant: 8),
            viewImage.heightAnchor.constraint(equalToConstant: 16),
            imageViewIcon.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            imageViewIcon.centerYAnchor.constraint(equalTo: viewImage.centerYAnchor),

            viewButtonContainer.widthAnchor.constraint(equalToConstant: 92),
            buttonPay.trailingAnchor.constraint(equalTo: viewButtonContainer.trailingAnchor),
            buttonPay.centerYAnchor.constraint(equalTo: viewButtonContainer.centerYAnchor)
        ])
    }
}
