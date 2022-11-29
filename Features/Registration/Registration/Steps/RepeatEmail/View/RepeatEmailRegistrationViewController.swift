//
//  RepeatEmailRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 24/11/22.
//

import UIKit

public class RepeatEmailRegistrationViewController: UIViewController {
    // MARK: - Constrants
    let viewModel = RegistrationViewModel.sharedRegistration
    
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    var email: String = ""
    var repeatEmail: String = ""
    
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
        let attrString = NSMutableAttributedString(string: "Para confirmar, digita novamente\nseu e-mail, por favor.")
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
    
    fileprivate let labelInfo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let textFieldEmail: UITextField = {
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
    
    fileprivate let labelAgreeTerms: UITextView = {
        let attrString = NSMutableAttributedString(string: "Ao cliclar em \"Finalizar\" você autoriza o SuperBank a coletar seus dados pessoais de acordo com a nossa Política de Privacidade, com o objetivo de comunicar informações sobre o proccesso de abertura da sua conta")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = UIColor(named: "Background")
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = UIColor(named: "Text")
        textView.attributedText = attrString
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        setTextWithLink()
        
        self.viewModel.finishRegister = { login in
            self.coordinatorDelegate?.goToCompletedRegistration(login: login)
        }
        
        self.email = viewModel.getEmail()
        self.labelInfo.text = self.email
        
        self.textFieldEmail.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction func GoButtonTapped(_ sender: UIButton) {
        self.buttonGo.isEnabled = false
        self.buttonGo.setTitle("", for: .normal)
        self.buttonGo.configuration?.showsActivityIndicator = true
        self.viewModel.registerCustomer()
    }
    
    // MARK: - Methods
    fileprivate func validateInput(_ isValid: Bool) {
        if isValid {
            self.textFieldEmail.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldEmail.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }
    
    fileprivate func settingButton(isDisabled: Bool) {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        if isDisabled {
            self.buttonGo.configuration?.baseForegroundColor = .gray
            self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonGo.configuration?.attributedTitle = AttributedString("Digite novamente o seu e-mail", attributes: container)
            self.buttonGo.isEnabled = false
            return
        }
        
        self.buttonGo.configuration?.baseForegroundColor = UIColor(named: "White")
        self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.buttonGo.configuration?.attributedTitle = AttributedString("Finalizar", attributes: container)
        self.buttonGo.isEnabled = true
    }
    
    fileprivate func setTextWithLink() {
        let textViewAttributedString = NSMutableAttributedString(string: self.labelAgreeTerms.text)
        textViewAttributedString.addAttributes([.font: UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor(named: "Text") ?? .red], range: NSRange(location: 0, length: textViewAttributedString.length))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        textViewAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, textViewAttributedString.length))
        
        
        let foundRange = textViewAttributedString.mutableString.range(of: "Política de Privacidade")
        textViewAttributedString.addAttribute(.link, value: "Política de Privacidade", range: foundRange)
        textViewAttributedString.addAttributes([.strikethroughColor : UIColor(named: "Primary") ?? .black, .underlineStyle : 1, .underlineColor : UIColor(named: "Primary") ?? .black, .font: UIFont.systemFont(ofSize: 14)], range: foundRange)
        
        self.labelAgreeTerms.attributedText = textViewAttributedString
        self.labelAgreeTerms.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary") ?? .black]
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
        stackContent.addArrangedSubview(labelAgreeTerms)
        
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

extension RepeatEmailRegistrationViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if email == updatedString {
                self.validateInput(true)
            } else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}


