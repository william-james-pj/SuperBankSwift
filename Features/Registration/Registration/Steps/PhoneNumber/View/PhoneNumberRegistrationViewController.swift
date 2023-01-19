//
//  PhoneNumberRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit

public class PhoneNumberRegistrationViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = RegistrationViewModel.sharedRegistration
    
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    private var phoneNumber: String = ""
    
    // MARK: - Components
    private let stackBase: UIStackView = {
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
    
    private let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Qual é o número do seu celular?")
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
    
    private let labelInfo: UILabel = {
        let attrString = NSMutableAttributedString(string: "Insira seu número de celular principal.Futuras\nrecuperação de senha ou informações sobre sua\nconta serão enviadas para este número.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldPhoneNumber: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "(00) 00000-0000",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? UIColor.black]
        )
        textField.accessibilityIdentifier = "PhoneNumberRegistration_TextField_BirthDate"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let buttonGo: ButtonPrimary = {
        let button = ButtonPrimary()
        button.accessibilityIdentifier = "PhoneNumberRegistration_Button_GO"
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
    private func setupVC() {
        view.accessibilityIdentifier = "Registration_VC_PhoneNumber"
        view.backgroundColor = UIColor(named: "Background")
        settingButton(isDisabled: true)
        buildHierarchy()
        buildConstraints()
        
        self.textFieldPhoneNumber.delegate = self
        self.textFieldPhoneNumber.addTarget(self, action: #selector(formattedPhoneNumberMask(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction private func GoButtonTapped(_ sender: UIButton) {
        self.viewModel.setPhoneNumber(phoneNumber)
        self.coordinatorDelegate?.goToEmail()
    }
    
    // MARK: - Methods
    private func validateInput(_ isValid: Bool) {
        if isValid {
            self.textFieldPhoneNumber.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldPhoneNumber.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }
    
    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.settingDisabled(true, text: "Digite seu telefone")
            return
        }
        self.buttonGo.settingDisabled(false, text: "Avançar")
    }
    
    @objc private func formattedPhoneNumberMask(_ textField: UITextField){
        if let text = textField.text {
            textField.text = self.viewModel.formartPhoneNumberMask(text)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = keyboardFrame.size.height - 25
        })
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let info = notification.userInfo!
        let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = 0
        })
    }
    
    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelTitle)
        stackContent.addArrangedSubview(labelInfo)
        stackContent.addArrangedSubview(textFieldPhoneNumber)
        
        stackBase.addArrangedSubview(buttonGo)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldPhoneNumber.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

extension PhoneNumberRegistrationViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if updatedString.count == 15 {
                self.validateInput(true)
            }
            else if updatedString.count > 15 {
                return false
            }
            else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}
