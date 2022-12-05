//
//  LoginViewController.swift
//  Login
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common
import RxSwift

public class LoginViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = LoginViewModel()
    private let isPerformingTask = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Variables
    public weak var coordinatorDelegate: LoginCoordinatorDelegate?
    private var isTypingPassword: Bool = false
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
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
    
    private let imageViewLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackTokenNewAccount: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonToken: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(named: "Text")
        config.titleAlignment = .center
        config.contentInsets = NSDirectionalEdgeInsets(top: 8,
          leading: 16, bottom: 8, trailing: 8)
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("Token", attributes: container)
        
        let button = UIButton(configuration:config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonNewAccount: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(named: "Text")
        config.titleAlignment = .center
        config.contentInsets = NSDirectionalEdgeInsets(top: 8,
          leading: 8, bottom: 8, trailing: 16)
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("Abrir conta", attributes: container)
        
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(RegistrationButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewAccountContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Text")
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewAccountArrowDown: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "White")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackAccount: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelAccountName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelAccountNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewFormContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackForm: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let textFieldAccount: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "Text")
        textField.font = .systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Número da conta",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? .gray]
        )
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let stackPasswordInput: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "Text")
        textField.text = ""
        textField.font = .systemFont(ofSize: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "* * * * *",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? .gray]
        )
        textField.isEnabled = false
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let labelPasswordError: UILabel = {
        let label = UILabel()
        label.text = "Senha inválida"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Red")
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewFormAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewPasswordButtons: PasswordButtons = {
        let view = PasswordButtons()
        view.isHidden = true
        return view
    }()
    
    private let buttonAccess: LoginButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        let button = LoginButton()
        button.configuration?.attributedTitle = AttributedString("CONTINUAR", attributes: container)
        button.addTarget(self, action: #selector(AccontbuttonTapped(_:)), for: .touchUpInside)
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
        view.backgroundColor = UIColor(named: "Background")
        buildHierarchy()
        buildConstraints()
        getPasswordText()
        validateInput(false)
        settingClosures()
        settingTextField()
        
        self.viewPasswordButtons.delegate = self
    }
    
    // MARK: - Actions
    @IBAction private func RegistrationButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.goToRegistration()
    }
    
    @IBAction private func AccontbuttonTapped(_ sender: UIButton) {
        if isTypingPassword {
            self.isPerformingTask.onNext(true)
            self.viewModel.logIn()
            return
        }
        
        if let text = self.textFieldAccount.text {
            self.isPerformingTask.onNext(true)
            
            Task {
                await self.viewModel.getAccount(text)
                self.isPerformingTask.onNext(false)
            }
        }
    }
    
    // MARK: - Methods
    private func settingAccessAccount() {
        self.isTypingPassword = true
        self.textFieldAccount.isHidden = true
        self.stackPasswordInput.isHidden = false
        self.viewAccountContainer.isHidden = false
        self.viewPasswordButtons.isHidden = false
    }
    
    fileprivate func validateInput(_ isValid: Bool) {
        if isValid {
            self.buttonAccess.configuration?.baseForegroundColor = UIColor(named: "White")
            self.buttonAccess.configuration?.baseBackgroundColor = UIColor(named: "Primary")
            self.buttonAccess.isEnabled = true
            return
        }
        
        self.labelPasswordError.isHidden = true
        self.buttonAccess.configuration?.baseForegroundColor = .gray
        self.buttonAccess.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
        self.buttonAccess.isEnabled = false
    }
    
    private func settingLoadingButton(_ isLoading: Bool) {
        if isLoading {
            self.textFieldAccount.isEnabled = false
            self.buttonAccess.isEnabled = false
            self.buttonAccess.configuration?.attributedTitle = getButtonAttributedString("")
            self.buttonAccess.configuration?.showsActivityIndicator = true
            return
        }
        self.buttonAccess.configuration?.showsActivityIndicator = false
        self.buttonAccess.configuration?.attributedTitle = getButtonAttributedString("ACESSAR")
        return
    }
    
    private func settingTextField() {
        self.textFieldAccount.delegate = self
        self.textFieldAccount.addBottomBorder(color: UIColor(named: "Text"), height: 1)
        self.textFieldAccount.addTarget(self, action: #selector(formattedAccountMask(_:)), for: .editingChanged)
        self.textFieldPassword.addBottomBorder(color: UIColor(named: "Text"), height: 1)
        self.buttonAccess.configuration?.attributedTitle = getButtonAttributedString("CONTINUAR")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    fileprivate func settingClosures() {
        self.isPerformingTask.subscribe(onNext: { element in
            self.settingLoadingButton(element)
            if !element {
                self.settingAccessAccount()
            }
        }).disposed(by: disposeBag)
        
        self.viewModel.updateAccountUI = { customerName, accountNumber in
            DispatchQueue.main.async {
                let name = customerName.components(separatedBy: " ")
                self.labelAccountName.text = name[0]
                self.labelAccountNumber.text = accountNumber
            }
        }
        
        self.viewModel.updatePasswordTextField = { isRemoving in
            var text = self.textFieldPassword.text ?? ""
            
            if !isRemoving {
                self.textFieldPassword.text = "0" + text
                return
            }
            
            if text.count == 5 {
                self.validateInput(false)
                self.viewPasswordButtons.settingButtons(false)
            }
            
            text.remove(at: text.index(before: text.endIndex))
            self.textFieldPassword.text = text
            
        }
        
        self.viewModel.finalizedPassword = {
            self.validateInput(true)
            self.viewPasswordButtons.settingButtons(true)
        }
        
        self.viewModel.invalidPassword = {
            self.labelPasswordError.isHidden = false
            self.textFieldPassword.text = ""
            self.isPerformingTask.onNext(false)
            self.viewPasswordButtons.settingButtons(false)
            self.validateInput(false)
        }
        
        self.viewModel.loggedIn = {
            self.coordinatorDelegate?.didAuthenticate()
        }
    }
    
    private func getPasswordText() {
        let gp = GeneratePasswordButtonText()
        self.viewPasswordButtons.settingTitles(gp.generationText())
    }
    
    private func getButtonAttributedString(_ text: String) -> AttributedString {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 16, weight: .bold)
        return AttributedString(text, attributes: container)
    }
    
    @objc fileprivate func formattedAccountMask(_ textField: UITextField){
        if let text = textField.text {
            let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let mask = "#######"
            var result = ""
            var index = cleanPhoneNumber.startIndex
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "#" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            textField.text = result
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = keyboardFrame.size.height
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
        
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewLogo)
        
        stackBase.addArrangedSubview(stackTokenNewAccount)
        stackTokenNewAccount.addArrangedSubview(buttonToken)
        stackTokenNewAccount.addArrangedSubview(buttonNewAccount)
        
        stackBase.addArrangedSubview(viewAccountContainer)
        viewAccountContainer.addSubview(imageViewAccountArrowDown)
        viewAccountContainer.addSubview(stackAccount)
        stackAccount.addArrangedSubview(labelAccountName)
        stackAccount.addArrangedSubview(labelAccountNumber)
        
        stackBase.addArrangedSubview(viewFormContainer)
        viewFormContainer.addSubview(stackForm)
        stackForm.addArrangedSubview(textFieldAccount)
        
        stackForm.addArrangedSubview(stackPasswordInput)
        stackPasswordInput.addArrangedSubview(labelPassword)
        stackPasswordInput.addArrangedSubview(textFieldPassword)
        stackPasswordInput.addArrangedSubview(labelPasswordError)
        
        stackForm.addArrangedSubview(viewPasswordButtons)
        stackForm.addArrangedSubview(buttonAccess)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageViewLogo.widthAnchor.constraint(equalToConstant: 100),
            imageViewLogo.heightAnchor.constraint(equalToConstant: 66),
            imageViewLogo.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageViewLogo.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor),
            
            viewAccountContainer.heightAnchor.constraint(equalToConstant: 75),
            
            stackAccount.topAnchor.constraint(equalTo: viewAccountContainer.topAnchor, constant: 16),
            stackAccount.leadingAnchor.constraint(equalTo: viewAccountContainer.leadingAnchor, constant: 16),
            stackAccount.trailingAnchor.constraint(equalTo: viewAccountContainer.trailingAnchor, constant: -16),
            stackAccount.bottomAnchor.constraint(equalTo: viewAccountContainer.bottomAnchor, constant: -16),
            
            stackForm.topAnchor.constraint(equalTo: viewFormContainer.topAnchor, constant: 16),
            stackForm.leadingAnchor.constraint(equalTo: viewFormContainer.leadingAnchor, constant: 16),
            stackForm.trailingAnchor.constraint(equalTo: viewFormContainer.trailingAnchor, constant: -16),
            stackForm.bottomAnchor.constraint(equalTo: viewFormContainer.bottomAnchor, constant: -16),
            
            textFieldAccount.heightAnchor.constraint(equalToConstant: 40),
            
            imageViewAccountArrowDown.widthAnchor.constraint(equalToConstant: 20),
            imageViewAccountArrowDown.centerYAnchor.constraint(equalTo: viewAccountContainer.centerYAnchor),
            imageViewAccountArrowDown.trailingAnchor.constraint(equalTo: viewAccountContainer.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: - extension UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if updatedString.count == 7 {
                self.validateInput(true)
            }
            else if updatedString.count > 7 {
                return false
            }
            else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}

// MARK: - extension PasswordButtonsDelegate
extension LoginViewController: PasswordButtonsDelegate {
    func getPasswordCharacter(_ character: ButtonPasswordText) {
        self.viewModel.setTypedPassword(character)
    }
    
    func removeLastTypedPassword() {
        self.viewModel.removeLastTypedPassword()
    }
}
