//
//  RequestCardCollectionViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 07/12/22.
//

import UIKit

class RequestCardCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "RequestCardCollectionViewCell"
    
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RequestCard")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let viewLineContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewLine: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(named: "Card")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewStackContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Solicite seu cartão"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "Card")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSubTitle: UILabel = {
        let label = UILabel()
        label.text = "Sem anuidade e muitos benefícios."
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Card")
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
        self.backgroundColor = UIColor(named: "Primary")
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageView)
        
        stackBase.addArrangedSubview(viewLineContainer)
        viewLineContainer.addSubview(viewLine)
        
        stackBase.addArrangedSubview(viewStackContainer)
        viewStackContainer.addSubview(stackText)
        stackText.addArrangedSubview(labelTitle)
        stackText.addArrangedSubview(labelSubTitle)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            viewImageContainer.widthAnchor.constraint(equalToConstant: 41),
            imageView.widthAnchor.constraint(equalToConstant: 41),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            imageView.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            
            viewLineContainer.widthAnchor.constraint(equalToConstant: 1),
            viewLine.widthAnchor.constraint(equalToConstant: 1),
            viewLine.heightAnchor.constraint(equalToConstant: 34),
            viewLine.centerYAnchor.constraint(equalTo: viewLineContainer.centerYAnchor),
            viewLine.centerXAnchor.constraint(equalTo: viewLineContainer.centerXAnchor),
            
            stackText.centerYAnchor.constraint(equalTo: viewStackContainer.centerYAnchor),
            stackText.leadingAnchor.constraint(equalTo: viewStackContainer.leadingAnchor),
        ])
    }
}
