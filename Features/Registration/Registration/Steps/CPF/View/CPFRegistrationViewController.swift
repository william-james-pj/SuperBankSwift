//
//  CPFRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit
import RxSwift

public class CPFRegistrationViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = RegistrationViewModel.sharedRegistration
    private let finishedVerification = PublishSubject<String>()
    private let disposeBag = DisposeBag()

    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    private var cpf: String = ""
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
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelWelcome: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Agora, precisamos do número do\nseu CPF.")
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
        let attrString = NSMutableAttributedString(
            string: """
                    Pedimos essa informação apenas por questões
                    regulatórias. Não se preocupe, seus dados estão
                    protegidos aqui no SuperBank.
                    """
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textFieldCPF: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "000.000.00-00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? UIColor.black]
        )
        textField.accessibilityIdentifier = "CPFRegistration_TextField_CPF"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let labelError: UILabel = {
        let attrString = NSMutableAttributedString(string: "Esse CPF já esta em uso, digite novamente ou faça login.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Red")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    private lazy var buttonGo: ButtonPrimary = {
        let button = ButtonPrimary()
        button.accessibilityIdentifier = "CPFRegistration_Button_GO"
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
        view.accessibilityIdentifier = "Registration_VC_CPF"
        view.backgroundColor = UIColor(named: "Background")
        settingButton(isDisabled: true)
        settingLabelText()
        buildHierarchy()
        buildConstraints()

        self.finishedVerification.subscribe { _ in
            self.buttonGo.settingLoading(false)
            self.coordinatorDelegate?.goToBirthDate()
        }.disposed(by: disposeBag)

        self.textFieldCPF.delegate = self
        self.textFieldCPF.addTarget(self, action: #selector(formattedCPFMask(_:)), for: .editingChanged)
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
        Task {
            self.buttonGo.settingLoading(true)
            let isValid = await self.viewModel.validateCPF(cpf)

            if isValid {
                self.finishedVerification.onNext("")
                return
            }

            self.buttonGo.settingLoading(false)
            self.settingError(to: true)
        }
    }

    // MARK: - Methods
    private func settingLabelText() {
        let name = viewModel.getFirstAndSecondName()
        self.labelWelcome.text = "Prazer em te conhecer, \(name)."
    }

    private func validateInput(_ isValid: Bool) {
        if isError {
            self.settingError(to: false)
        }

        if isValid {
            self.textFieldCPF.textColor = UIColor(named: "Green")
            self.settingButton(isDisabled: false)
            return
        }
        self.textFieldCPF.textColor = UIColor(named: "Text")
        self.settingButton(isDisabled: true)
    }

    private func settingError(to activeError: Bool) {
        if activeError {
            self.isError = true
            self.textFieldCPF.textColor = UIColor(named: "Red")
            self.labelError.isHidden = false
            return
        }
        self.isError = false
        self.labelError.isHidden = true
    }

    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.settingDisabled(true, text: "Digite o número do CPF")
            return
        }
        self.buttonGo.settingDisabled(false, text: "Avançar")
    }

    @objc private func formattedCPFMask(_ textField: UITextField) {
        if let text = textField.text {
            textField.text = self.viewModel.formatCPFMask(text)
        }
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
        let info = notification.userInfo!
        // swiftlint:disable force_cast
        let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        // swiftlint:enable force_cast

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = 0
        })
    }

    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelWelcome)
        stackContent.addArrangedSubview(labelTitle)
        stackContent.addArrangedSubview(labelInfo)
        stackContent.addArrangedSubview(textFieldCPF)
        stackContent.addArrangedSubview(labelError)

        stackBase.addArrangedSubview(buttonGo)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            textFieldCPF.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension CPFRegistrationViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        if let updatedString = updatedString {
            if updatedString.count == 14 {
                self.validateInput(true)
            } else if updatedString.count > 14 {
                return false
            } else {
                self.validateInput(false)
            }
        }

        return true
    }
}
