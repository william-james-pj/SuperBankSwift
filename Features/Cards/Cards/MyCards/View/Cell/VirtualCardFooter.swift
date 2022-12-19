//
//  VirtualCardFooter.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import UIKit

protocol VirtualCardFooterDelegate {
    func newCardButtonPressed()
}

class VirtualCardFooter: UITableViewHeaderFooterView {
    // MARK: - Constrants
    static let resuseIdentifier: String = "DrawerHeader"
    
    // MARK: - Variables
    var delegate: VirtualCardFooterDelegate?
    
    // MARK: - Components
    private let buttonNewCard: UIButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "Text")
        config.baseBackgroundColor = UIColor(named: "Card")
        config.attributedTitle = AttributedString("Criar cartão virtual", attributes: container)

        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(AddNewCardButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @IBAction private func AddNewCardButtonTapped(_ sender: UIButton) {
        self.delegate?.newCardButtonPressed()
    }
    
    // MARK: - Setup
    private func setupView() {
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        self.addSubview(buttonNewCard)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            buttonNewCard.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            buttonNewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttonNewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttonNewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
