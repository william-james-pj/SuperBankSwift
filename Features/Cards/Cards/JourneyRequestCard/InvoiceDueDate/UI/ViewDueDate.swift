//
//  ViewDueDate.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import UIKit

class ViewDueDate: UIView {    
    // MARK: - Components
    fileprivate let viewBase: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonSelect: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
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
        self.layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func setText(_ text: String) {
        self.labelText.text = text
    }
    
    func selectView() {
        self.backgroundColor = UIColor(named: "Primary")
        self.labelText.textColor = UIColor(named: "Card")
    }
    
    func deselectView() {
        self.backgroundColor = UIColor(named: "Card")
        self.labelText.textColor = UIColor(named: "Text")
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(viewBase)
        viewBase.addSubview(labelText)
        viewBase.addSubview(buttonSelect)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 55),
            self.heightAnchor.constraint(equalToConstant: 55),
            
            viewBase.widthAnchor.constraint(equalToConstant: 50),
            viewBase.heightAnchor.constraint(equalToConstant: 50),
            viewBase.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewBase.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelText.topAnchor.constraint(equalTo: viewBase.topAnchor),
            labelText.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor),
            labelText.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor),
            labelText.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor),
            
            buttonSelect.topAnchor.constraint(equalTo: viewBase.topAnchor),
            buttonSelect.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor),
            buttonSelect.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor),
            buttonSelect.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor),
        ])
    }

}
