//
//  FullNameRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit

public class FullNameRegistrationViewController: UIViewController {
    // MARK: - Constrants
    let viewModel = RegistrationViewModel.sharedRegistration
    
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Antes de começarmos, qual seu\nnome completo?")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let textFieldName: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Nome completo",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? UIColor.black]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate let buttonGo: RegistrationButton = {
        let button = RegistrationButton()
        button.addTarget(self, action: #selector(GoButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        settingButton(isDisabled: true)
        buildHierarchy()
        buildConstraints()
        
        self.textFieldName.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction func GoButtonTapped(_ sender: UIButton) {
        guard let name = self.textFieldName.text else {
            return
        }
        viewModel.setName(name)
        self.coordinatorDelegate?.goToCPF()
    }
    
    // MARK: - Methods
    fileprivate func validateInput(_ isValid: Bool) {
        if isValid {
            self.textFieldName.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldName.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }
    
    fileprivate func settingButton(isDisabled: Bool) {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        if isDisabled {
            self.buttonGo.configuration?.baseForegroundColor = .gray
            self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonGo.configuration?.attributedTitle = AttributedString("Digite seu nome para continuar", attributes: container)
            self.buttonGo.isEnabled = false
            return
        }
        
        self.buttonGo.configuration?.baseForegroundColor = UIColor(named: "White")
        self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.buttonGo.configuration?.attributedTitle = AttributedString("Avançar", attributes: container)
        self.buttonGo.isEnabled = true
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = keyboardFrame.size.height - 25
        })
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        let info = notification.userInfo!
        let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = 0
        })
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelTitle)
        stackContent.addArrangedSubview(textFieldName)
        
        stackBase.addArrangedSubview(buttonGo)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldName.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

extension FullNameRegistrationViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            let textArr = updatedString.components(separatedBy: " ")
            if textArr.count > 1 {
                let length = textArr[1].count
                if length >= 3 {
                    self.validateInput(true)
                } else {
                    self.validateInput(false)
                }
            } else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}
