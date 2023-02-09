//
//  RepeatEmailRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 24/11/22.
//

import UIKit

public class RepeatEmailRegistrationViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = RegistrationViewModel.sharedRegistration

    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    private var email: String = ""
    private var repeatEmail: String = ""

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
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Para confirmar, digita novamente\nseu e-mail, por favor.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelInfo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
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

    private let labelAgreeTerms: UITextView = {
        // swiftlint:disable line_length
        let attrString = NSMutableAttributedString(
            string: """
                    Ao clicar em \"Finalizar\" você autoriza o SuperBank a coletar seus dados pessoais de acordo com a nossa Política de Privacidade, com o objetivo de comunicar informações sobre o processo de abertura da sua conta
                    """
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

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

    private lazy var buttonGo: ButtonPrimary = {
        let button = ButtonPrimary()
        button.addTarget(self, action: #selector(goButtonTapped(_:)), for: .touchUpInside)
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
        setTextWithLink()

        self.viewModel.finishRegister = { login in
            DispatchQueue.main.async {
                self.buttonGo.settingLoading(false)
                self.coordinatorDelegate?.goToCompletedRegistration(login: login)
            }
        }

        self.email = viewModel.getEmail()
        self.labelInfo.text = self.email

        self.textFieldEmail.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Actions
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        self.buttonGo.settingLoading(true)
        Task {
            await self.viewModel.registerCustomer()
        }
    }

    // MARK: - Methods
    private func validateInput(_ isValid: Bool) {
        if isValid {
            self.textFieldEmail.textColor = UIColor(named: "Green")
            settingButton(isDisabled: false)
            return
        }
        self.textFieldEmail.textColor = UIColor(named: "Text")
        settingButton(isDisabled: true)
    }

    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.settingDisabled(true, text: "Digite novamente o seu e-mail")
            return
        }
        self.buttonGo.settingDisabled(false, text: "Avançar")
    }

    private func setTextWithLink() {
        let textViewAttributedString = NSMutableAttributedString(string: self.labelAgreeTerms.text)
        textViewAttributedString.addAttributes(
            [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(named: "Text") ?? .red
            ],
            range: NSRange(location: 0, length: textViewAttributedString.length))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        textViewAttributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: textViewAttributedString.length)
        )

        let foundRange = textViewAttributedString.mutableString.range(of: "Política de Privacidade")
        textViewAttributedString.addAttribute(.link, value: "Política de Privacidade", range: foundRange)
        textViewAttributedString.addAttributes(
            [
                .strikethroughColor: UIColor(named: "Primary") ?? .black,
                .underlineStyle: 1, .underlineColor: UIColor(named: "Primary") ?? .black,
                .font: UIFont.systemFont(ofSize: 14)
            ],
            range: foundRange
        )

        self.labelAgreeTerms.attributedText = textViewAttributedString
        self.labelAgreeTerms.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary") ?? .black
        ]
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        // swiftlint:disable force_cast
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        // swiftlint:enable force_cast

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = keyboardFrame.size.height - 25
        })
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
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
        stackContent.addArrangedSubview(labelAgreeTerms)

        stackBase.addArrangedSubview(buttonGo)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            textFieldEmail.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension RepeatEmailRegistrationViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
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
