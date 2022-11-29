//
//  InfoBox.swift
//  Registration
//
//  Created by Pinto Junior, William James on 24/11/22.
//

import UIKit

class InfoBox: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelSubTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupView() {
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingView(_ title: String, _ subTitle: String) {
        self.labelTitle.text = title
        self.labelSubTitle.text = subTitle
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(labelSubTitle)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
