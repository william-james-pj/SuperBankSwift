//
//  LoginViewController.swift
//  Login
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common

public protocol LoginCoordinatorDelegate: AnyObject {
    func goToRegistration()
}

public class LoginViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let stackTokenNewAccount: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let buttonToken: UIButton = {
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
    
    fileprivate let buttonNewAccount: UIButton = {
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
    
    fileprivate let viewAccountContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Text")
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewAccountArrowDown: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "White")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let stackAccount: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelAccountName: UILabel = {
        let label = UILabel()
        label.text = "WILLIAM"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelAccountNumber: UILabel = {
        let label = UILabel()
        label.text = "9423170"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewFormContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackForm: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let textFieldAccount: UITextField = {
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
    
    fileprivate let stackPasswordInput: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let textFieldPassword: UITextField = {
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
    
    fileprivate let buttonAccess: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .large
        
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(AccontbuttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let viewFormAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewPasswordButtons: PasswordButtons = {
        let view = PasswordButtons()
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        buildHierarchy()
        buildConstraints()
        getPasswordText()
        
        self.textFieldAccount.addBottomBorder(color: UIColor(named: "Text"), height: 1)
        self.textFieldPassword.addBottomBorder(color: UIColor(named: "Text"), height: 1)
        self.buttonAccess.configuration?.attributedTitle = getButtonAttributedString("CONTINUAR")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Methods
    @IBAction func RegistrationButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.goToRegistration()
    }
    
    @IBAction func AccontbuttonTapped(_ sender: UIButton) {
        self.buttonAccess.configuration?.attributedTitle = getButtonAttributedString("ACESSAR")
        self.textFieldAccount.isHidden = true
        self.stackPasswordInput.isHidden = false
        self.viewAccountContainer.isHidden = false
        self.viewPasswordButtons.isHidden = false
    }
    
    fileprivate func getPasswordText() {
        let gp = GeneratePasswordButtonText()
        self.viewPasswordButtons.settingTitles(gp.generationText())
    }
    
    fileprivate func getButtonAttributedString(_ text: String) -> AttributedString {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 16, weight: .bold)
        return AttributedString(text, attributes: container)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = keyboardFrame.size.height
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
        
        stackForm.addArrangedSubview(viewPasswordButtons)
        stackForm.addArrangedSubview(buttonAccess)
    }
    
    fileprivate func buildConstraints() {
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


