//
//  EmailRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 24/11/22.
//

import UIKit
import RxSwift

public class EmailRegistrationViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = RegistrationViewModel.sharedRegistration
    private let finishedVerification = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    private var isError = false
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Qual é o seu e-mail pessoal?")
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
        let attrString = NSMutableAttributedString(string: "Insira um e-mail que você costuma utilizar sempre.\nÉ para este e-mail que os dados de acesso à sua\nconta SuperBank serão enviados.")
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
    
    private let textFieldEmail: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "meuemail@exemplo.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? UIColor.black]
        )
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let labelErro: UILabel = {
        let attrString = NSMutableAttributedString(string: "Esse email já esta em uso, digite novamente ou faça login.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Red")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let buttonGo: ButtonPrimary = {
        let button = ButtonPrimary()
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
        view.backgroundColor = UIColor(named: "Background")
        settingButton(isDisabled: true)
        buildHierarchy()
        buildConstraints()
        
        self.finishedVerification.subscribe { e in
            self.buttonGo.settingLoading(false)
            self.coordinatorDelegate?.goToRepeatEmail()
        }.disposed(by: disposeBag)
        
        self.textFieldEmail.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction private func GoButtonTapped(_ sender: UIButton) {
        Task {
            guard let email = self.textFieldEmail.text else {
                return
            }
            self.buttonGo.settingLoading(true)
            let isValid = await self.viewModel.validateEmail(email)
            
            if isValid {
                self.finishedVerification.onNext("")
                return
            }
            
            self.buttonGo.settingLoading(false)
            self.settingError(to: true)
        }
    }
    
    // MARK: - Methods
    private func validateInput(_ isValid: Bool) {
        if isError {
            self.settingError(to: false)
        }
        
        if isValid {
            self.textFieldEmail.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldEmail.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }
    
    private func settingError(to activeError: Bool) {
        if activeError {
            self.isError = true
            self.textFieldEmail.textColor = UIColor(named: "Red")
            self.labelErro.isHidden = false
            return
        }
        self.isError = false
        self.labelErro.isHidden = true
    }
    
    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.settingDisabled(true, text: "Informe um e-mail")
            return
        }
        self.buttonGo.settingDisabled(false, text: "Avançar")
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
        stackContent.addArrangedSubview(textFieldEmail)
        stackContent.addArrangedSubview(labelErro)
        
        stackBase.addArrangedSubview(buttonGo)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldEmail.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

extension EmailRegistrationViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            let isValid = self.viewModel.validateEmailMask(updatedString)
            self.validateInput(isValid)
        }
        
        return true
    }
}

