//
//  NewVirtualCardViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 16/12/22.
//

import UIKit
import Common

public protocol NewVirtualCardVCDelegate: AnyObject {
    func finalizeSavingCard()
}

public class NewVirtualCardViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = NewVirtualCardViewModel()

    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    public weak var delegate: NewVirtualCardVCDelegate?
    public var accountId: String?
    private var charactersTyped = 0

    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
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

    private let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelSection: UILabel = {
        let label = UILabel()
        label.text = "Crie seu cartão virtual"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelInfo: UILabel = {
        // swiftlint:disable line_length
        let attrString = NSMutableAttributedString(
            string: """
                    Dê um nome personalizado para organizar e identificar as compras que você faz em cada cartão virtual.
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackInput: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelInput: UILabel = {
        let label = UILabel()
        label.text = "Como você quer chamar esse cartão?"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textFieldCardName: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "Text")
        textField.font = .systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let labelInputInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Este nome só pode ser visto por você e não pode ser alterado depois de criar o cartão virtual"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelCharacters: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buttonNewCard: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("Criar cartão virtual")
        button.addTarget(self, action: #selector(newCardButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    // MARK: - Actions
    @IBAction private func newCardButtonTapped(_ sender: UIButton) {
        guard let nickname = textFieldCardName.text, let accountId = self.accountId else {
            return
        }
        self.buttonNewCard.settingLoading(true)
        Task {
            await self.viewModel.createVirtualCard(accountId: accountId, nickname: nickname)
        }
    }

    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        self.title = "Novo cartão virtual"

        settingButton(isDisabled: true)

        self.textFieldCardName.delegate = self
        self.textFieldCardName.addBottomBorder(color: UIColor(named: "Disabled"), height: 1)

        settingClosures()

        buildHierarchy()
        buildConstraints()

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

    // MARK: - Methods
    private func settingLabelCharacters(_ number: Int) {
        self.labelCharacters.text = "\(number)/20"
    }

    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonNewCard.settingDisabled(true, text: "Validar e Confirmar")
            return
        }
        self.buttonNewCard.settingDisabled(false, text: "Validar e Confirmar")
    }

    private func settingClosures() {
        self.viewModel.finishSavingCard = {
            DispatchQueue.main.async {
                self.buttonNewCard.settingLoading(false)
                self.delegate?.finalizeSavingCard()
                self.coordinatorDelegate?.finalizeSavingCard()
            }
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
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let constraint = self.stackBase.constraints.first(where: { $0.firstAttribute == .bottom })
            constraint?.constant = 0
        })
    }

    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(stackSection)
        stackSection.addArrangedSubview(labelSection)
        stackSection.addArrangedSubview(labelInfo)

        stackContent.addArrangedSubview(stackInput)
        stackInput.addArrangedSubview(labelInput)
        stackInput.addArrangedSubview(textFieldCardName)

        stackBase.addArrangedSubview(buttonNewCard)
        view.addSubview(labelCharacters)
        view.addSubview(labelInputInfo)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            textFieldCardName.heightAnchor.constraint(equalToConstant: 40),

            labelCharacters.widthAnchor.constraint(equalToConstant: 40),
            labelCharacters.topAnchor.constraint(equalTo: textFieldCardName.bottomAnchor, constant: 8),
            labelCharacters.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            labelInputInfo.topAnchor.constraint(equalTo: textFieldCardName.bottomAnchor, constant: 8),
            labelInputInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelInputInfo.trailingAnchor.constraint(equalTo: labelCharacters.leadingAnchor, constant: -16)
        ])
    }
}

// MARK: - extension UITextFieldDelegate
extension NewVirtualCardViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        if let updatedString = updatedString {
            if updatedString.count > 20 {
                return false
            }
            self.settingLabelCharacters(updatedString.count)

            if updatedString.count > 2 {
                self.settingButton(isDisabled: false)
            }

            if updatedString.count < 3 {
                self.settingButton(isDisabled: true)
            }
        }

        return true
    }
}
