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
        let attrString = NSMutableAttributedString(string: "Esse CPF já esta em uso, digite novamente ou faça login.")
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
    
    private let buttonGo: RegistrationButton = {
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
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        settingButton(isDisabled: true)
        buildHierarchy()
        buildConstraints()
        
        self.finishedVerification.subscribe { e in
            self.settingLoadingButton(false)
            self.coordinatorDelegate?.goToRepeatEmail()
        }.disposed(by: disposeBag)
        
        self.textFieldEmail.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction func GoButtonTapped(_ sender: UIButton) {
        Task {
            guard let email = self.textFieldEmail.text else {
                return
            }
            self.settingLoadingButton(true)
            let isValid = await self.viewModel.validateEmail(email)
            
            if isValid {
                self.finishedVerification.onNext("")
                return
            }
            
            self.settingLoadingButton(false)
            self.settingError(to: true)
        }
    }
    
    // MARK: - Methods
    fileprivate func validateInput(_ isValid: Bool) {
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
    
    fileprivate func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.configuration?.baseForegroundColor = .gray
            self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonGo.setTitle("Informe um e-mail", for: .normal)
            self.buttonGo.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            self.buttonGo.isEnabled = false
            return
        }
        
        self.buttonGo.configuration?.baseForegroundColor = UIColor(named: "White")
        self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.buttonGo.setTitle("Avançar", for: .normal)
        self.buttonGo.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        self.buttonGo.isEnabled = true
    }
    
    private func settingLoadingButton(_ isLoading: Bool) {
        if isLoading {
            self.textFieldEmail.isEnabled = false
            self.buttonGo.isEnabled = false
            self.buttonGo.setTitle("", for: .normal)
            self.buttonGo.configuration?.showsActivityIndicator = true
            return
        }
        self.textFieldEmail.isEnabled = true
        self.buttonGo.configuration?.showsActivityIndicator = false
        self.settingButton(isDisabled: true)
        return
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
        stackContent.addArrangedSubview(labelInfo)
        stackContent.addArrangedSubview(textFieldEmail)
        stackContent.addArrangedSubview(labelErro)
        
        stackBase.addArrangedSubview(buttonGo)
    }
    
    fileprivate func buildConstraints() {
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
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailPred.evaluate(with: updatedString) {
                self.validateInput(true)
            } else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}

