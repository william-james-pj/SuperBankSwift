//
//  CheckTerm.swift
//  Cards
//
//  Created by Pinto Junior, William James on 13/12/22.
//

import UIKit

protocol CheckTermDelegate {
    func buttonCheckPress(_ isChecked: Bool)
}

class CheckTerm: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    private var isChecked: Bool = false
    var delegate: CheckTermDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewButtonCheckContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonCheck: UIButton = {
        var config = UIButton.Configuration.gray()
        config.image = UIImage(named: "check-white")
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
        config.background.strokeColor = UIColor(named: "Text")
        config.background.strokeWidth = 1.0
     
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(CheckButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let labelCheck: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "Text")
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
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        settingButtonCheck()
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Actions
    @IBAction private func CheckButtonTapped(_ sender: UIButton) {
        self.isChecked = !self.isChecked
        self.settingButtonCheck()
        self.delegate?.buttonCheckPress(self.isChecked)
    }
    
    // MARK: - Methods
    func settingView(_ termText: String) {
        let attrString = NSMutableAttributedString(string: termText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        self.labelCheck.attributedText = attrString
    }
    
    private func settingButtonCheck() {
        if isChecked {
            self.buttonCheck.configuration?.baseBackgroundColor = UIColor(named: "Text")
            return
        }
        self.buttonCheck.configuration?.baseBackgroundColor = UIColor(named: "Background")
    }
    
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewButtonCheckContainer)
        viewButtonCheckContainer.addSubview(buttonCheck)
        stackBase.addArrangedSubview(labelCheck)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewButtonCheckContainer.widthAnchor.constraint(equalToConstant: 25),
            buttonCheck.widthAnchor.constraint(equalToConstant: 25),
            buttonCheck.centerXAnchor.constraint(equalTo: viewButtonCheckContainer.centerXAnchor),
            buttonCheck.centerYAnchor.constraint(equalTo: viewButtonCheckContainer.centerYAnchor),
        ])
    }
}
