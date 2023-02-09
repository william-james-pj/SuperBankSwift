//
//  MyCardsTableViewCell.swift
//  Cards
//
//  Created by Pinto Junior, William James on 07/12/22.
//

import UIKit
import Common

class MyCardsTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "MyCardsTableViewCell"

    // MARK: - Variables

    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let viewImageCardContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageViewCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "credit-card-front")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelCardName: UILabel = {
        let label = UILabel()
        label.text = "Compras"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelCardFinalNumber: UILabel = {
        let label = UILabel()
        label.text = "**** 1212"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewImageArrowContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageViewArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron-right")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    func settingView(card: CardModel) {
        self.labelCardName.text = card.nickname
        self.labelCardFinalNumber.text = formattingCardNumber(card.cardNumber)
    }

    private func formattingCardNumber(_ cardNumber: String) -> String {
        let lastNumber = cardNumber.suffix(4)
        return "•••• \(lastNumber)"
    }

    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageCardContainer)
        viewImageCardContainer.addSubview(imageViewCard)

        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelCardName)
        stackText.addArrangedSubview(labelCardFinalNumber)

        stackBase.addArrangedSubview(viewImageArrowContainer)
        viewImageArrowContainer.addSubview(imageViewArrow)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),

            viewImageCardContainer.widthAnchor.constraint(equalToConstant: 27),
            imageViewCard.widthAnchor.constraint(equalToConstant: 27),
            imageViewCard.heightAnchor.constraint(equalToConstant: 22),
            imageViewCard.centerYAnchor.constraint(equalTo: viewImageCardContainer.centerYAnchor),
            imageViewCard.centerXAnchor.constraint(equalTo: viewImageCardContainer.centerXAnchor),

            viewImageArrowContainer.widthAnchor.constraint(equalToConstant: 8),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 8),
            imageViewArrow.heightAnchor.constraint(equalToConstant: 14),
            imageViewArrow.centerYAnchor.constraint(equalTo: viewImageArrowContainer.centerYAnchor),
            imageViewArrow.centerXAnchor.constraint(equalTo: viewImageArrowContainer.centerXAnchor)
        ])
    }
}
