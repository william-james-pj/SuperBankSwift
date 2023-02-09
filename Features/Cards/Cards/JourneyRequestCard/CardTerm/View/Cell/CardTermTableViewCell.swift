//
//  CardTermTableViewCell.swift
//  Cards
//
//  Created by Pinto Junior, William James on 12/12/22.
//

import UIKit

class CardTermTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "CardTermTableViewCell"

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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelSubTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageViewArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron-right-black")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Disabled")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    func settingCell(_ cardTerm: CardTermModel) {
        self.labelTitle.text = cardTerm.title
        self.labelSubTitle.text = cardTerm.subTitle
    }

    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(labelSubTitle)

        self.addSubview(imageViewArrow)
        self.addSubview(viewLine)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),

            imageViewArrow.widthAnchor.constraint(equalToConstant: 8),
            imageViewArrow.heightAnchor.constraint(equalToConstant: 14),
            imageViewArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageViewArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            viewLine.heightAnchor.constraint(equalToConstant: 1),
            viewLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewLine.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
