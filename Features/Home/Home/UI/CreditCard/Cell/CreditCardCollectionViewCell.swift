//
//  CreditCardCollectionViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class CreditCardCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "CreditCardCollectionViewCell"
    
    // MARK: - Constrants
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
        label.text = "R$ 219,23"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonPay: UIButton = {
        let button = UIButton()
        button.setTitle("Pagar fatura", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "Primary")
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell() {
    }
    
    private func buildHierarchy() {
        self.addSubview(stackBase)
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
            buttonPay.centerYAnchor.constraint(equalTo: viewButtonContainer.centerYAnchor),
        ])
    }
}


