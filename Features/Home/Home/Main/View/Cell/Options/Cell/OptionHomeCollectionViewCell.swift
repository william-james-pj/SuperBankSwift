//
//  OptionHomeCollectionViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit

enum OptionHomeType {
    case pix
    case transfer
    case pay
    case card
    case edit
}

class OptionHomeCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "OptionHomeCollectionViewCell"

    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let viewBoxContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageViewItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    func settingCell(_ type: OptionHomeType) {
        switch type {
        case .pix:
            self.labelTitle.text = "Pix"
            self.imageViewItem.image = UIImage(named: "pix")
        case .transfer:
            self.labelTitle.text = "Transferir"
            self.imageViewItem.image = UIImage(named: "money-transfer")
        case .pay:
            self.labelTitle.text = "Pagar"
            self.imageViewItem.image = UIImage(named: "barcode")
        case .card:
            self.labelTitle.text = "Cartões"
            self.imageViewItem.image = UIImage(named: "credit-card")
        case .edit:
            self.labelTitle.text = "Editar"
            settingEditButton()
        }
    }

    private func settingEditButton () {
        self.viewBox.backgroundColor = UIColor(named: "Background")
        self.viewBox.layer.borderWidth = 1
        self.viewBox.layer.borderColor = UIColor(named: "Disabled")?.cgColor
        self.imageViewItem.tintColor = UIColor(named: "Primary")
        self.imageViewItem.image = UIImage(systemName: "plus")
    }

    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewBoxContainer)
        viewBoxContainer.addSubview(viewBox)
        viewBox.addSubview(imageViewItem)
        stackBase.addArrangedSubview(labelTitle)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            viewBox.leadingAnchor.constraint(equalTo: self.viewBoxContainer.leadingAnchor),
            viewBox.trailingAnchor.constraint(equalTo: self.viewBoxContainer.trailingAnchor),
            viewBox.centerYAnchor.constraint(equalTo: viewBoxContainer.centerYAnchor),

            imageViewItem.topAnchor.constraint(equalTo: viewBox.topAnchor, constant: 20),
            imageViewItem.leadingAnchor.constraint(equalTo: viewBox.leadingAnchor, constant: 20),
            imageViewItem.trailingAnchor.constraint(equalTo: viewBox.trailingAnchor, constant: -20),
            imageViewItem.bottomAnchor.constraint(equalTo: viewBox.bottomAnchor, constant: -20)
        ])
    }
}
