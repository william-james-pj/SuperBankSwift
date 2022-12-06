//
//  DrawerHeader.swift
//  Home
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import UIKit

protocol DrawerHeaderDelegate {
    func closeDrawer()
}

class DrawerHeader: UITableViewHeaderFooterView {
    // MARK: - Constrants
    static let resuseIdentifier: String = "DrawerHeader"
    
    // MARK: - Variables
    var delegate: DrawerHeaderDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackUser: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewUserBoxContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewUserBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelUserBox: UILabel = {
        let label = UILabel()
        label.text = "W"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelUserName: UILabel = {
        let label = UILabel()
        label.text = "William James"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonClose: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "Text")
        config.baseBackgroundColor = UIColor(named: "Background")
        config.image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))

        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(CloseButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let labelBank: UILabel = {
        let label = UILabel()
        label.text = "Super Bank - Instituição de Pagamento"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    @IBAction private func CloseButtonTapped(_ sender: UIButton) {
        self.delegate?.closeDrawer()
    }
    
    // MARK: - Setup
    private func setupView() {
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(stackRow)
        stackRow.addArrangedSubview(stackUser)
        stackUser.addArrangedSubview(viewUserBoxContainer)
        viewUserBoxContainer.addSubview(viewUserBox)
        viewUserBox.addSubview(labelUserBox)
        stackUser.addArrangedSubview(labelUserName)
        stackRow.addArrangedSubview(buttonClose)
        
        stackBase.addArrangedSubview(labelBank)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            viewUserBoxContainer.widthAnchor.constraint(equalToConstant: 45),
            viewUserBox.widthAnchor.constraint(equalToConstant: 45),
            viewUserBox.heightAnchor.constraint(equalToConstant: 45),
            viewUserBox.centerXAnchor.constraint(equalTo: viewUserBoxContainer.centerXAnchor),
            viewUserBox.centerYAnchor.constraint(equalTo: viewUserBoxContainer.centerYAnchor),
            
            labelUserBox.centerXAnchor.constraint(equalTo: viewUserBox.centerXAnchor),
            labelUserBox.centerYAnchor.constraint(equalTo: viewUserBox.centerYAnchor),
        ])
    }
}
