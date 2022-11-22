//
//  MyCardCollectionViewCell.swift
//  Cards
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class MyCardCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "MyCardCollectionViewCell"
    
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
     
    fileprivate let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelCardType: UILabel = {
        let label = UILabel()
        label.text = "Virtual"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let buttonEye: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eyeBlack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let buttonGear: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gearBlack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelDot1: UILabel = {
        let label = UILabel()
        label.text = "****  ****  ****"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelLastNumber: UILabel = {
        let label = UILabel()
        label.text = "4225"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewContentAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let stackFooter: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.text = "WILLIAM JAMES "
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelValidty: UILabel = {
        let label = UILabel()
        label.text = "**/**"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
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
    fileprivate func setupVC() {
        self.backgroundColor = UIColor(named: "Card")
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell() {
       
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(labelCardType)
        stackHeader.addArrangedSubview(viewButtonContainer)
        viewButtonContainer.addSubview(buttonEye)
        viewButtonContainer.addSubview(buttonGear)
        
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelDot1)
        stackContent.addArrangedSubview(labelLastNumber)
        stackContent.addArrangedSubview(viewContentAux)
        
        stackBase.addArrangedSubview(stackFooter)
        stackFooter.addArrangedSubview(labelName)
        stackFooter.addArrangedSubview(labelValidty)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            
            viewButtonContainer.widthAnchor.constraint(equalToConstant: 20),
            buttonGear.trailingAnchor.constraint(equalTo: viewButtonContainer.trailingAnchor),
            buttonGear.centerYAnchor.constraint(equalTo: viewButtonContainer.centerYAnchor),
            
            viewButtonContainer.widthAnchor.constraint(equalToConstant: 20),
            buttonEye.trailingAnchor.constraint(equalTo: buttonGear.leadingAnchor, constant: -16),
            buttonEye.centerYAnchor.constraint(equalTo: viewButtonContainer.centerYAnchor),
        ])
    }
}


