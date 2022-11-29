//
//  BirthDateRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit

public class BirthDateRegistrationViewController: UIViewController {
    // MARK: - Constrants
    let viewModel = RegistrationViewModel.sharedRegistration
    
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    var birthDate: String = ""
    
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
        let attrString = NSMutableAttributedString(string: "E qual é a sua data de nascimento?")
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
    
    fileprivate let textFieldBirthDate: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "dd/mm/yyyy",
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
        
        self.textFieldBirthDate.delegate = self
        self.textFieldBirthDate.addTarget(self, action: #selector(formattedBirthDateMask(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction func GoButtonTapped(_ sender: UIButton) {
        viewModel.setBirthDate(birthDate)
        self.coordinatorDelegate?.goToPhoneNumber()
    }
    
    // MARK: - Methods
    fileprivate func validateInput(_ isValid: Bool) {
        if isValid {
            self.textFieldBirthDate.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldBirthDate.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }
    
    fileprivate func settingButton(isDisabled: Bool) {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        if isDisabled {
            self.buttonGo.configuration?.baseForegroundColor = .gray
            self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonGo.configuration?.attributedTitle = AttributedString("Digite sua data de nascimento", attributes: container)
            self.buttonGo.isEnabled = false
            return
        }
        
        self.buttonGo.configuration?.baseForegroundColor = UIColor(named: "White")
        self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.buttonGo.configuration?.attributedTitle = AttributedString("Avançar", attributes: container)
        self.buttonGo.isEnabled = true
    }
    
    @objc fileprivate func formattedBirthDateMask(_ textField: UITextField){
        if let text = textField.text {
            let cleanBirthDate = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            self.birthDate = cleanBirthDate
            let mask = "##/##/####"
            var result = ""
            var index = cleanBirthDate.startIndex
            for ch in mask where index < cleanBirthDate.endIndex {
                if ch == "#" {
                    result.append(cleanBirthDate[index])
                    index = cleanBirthDate.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            textField.text = result
        }
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
        stackContent.addArrangedSubview(textFieldBirthDate)
        
        stackBase.addArrangedSubview(buttonGo)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldBirthDate.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

extension BirthDateRegistrationViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if updatedString.count == 10 {
                self.validateInput(true)
            } else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}
