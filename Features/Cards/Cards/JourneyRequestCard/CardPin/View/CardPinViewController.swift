//
//  CardPinViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import UIKit

public class CardPinViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = JourneyRequestCardViewModel.sharedJourneyRequestCard
    
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    private var isSecure = true
    
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
    
    private let labelSection: UILabel = {
        let attrString = NSMutableAttributedString(string: "Digite uma senha para o\nseu cartão")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSubText: UILabel = {
        let attrString = NSMutableAttributedString(string: "Essa senha será usada para\ncompras e transações.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewStackTextFieldContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackTextField: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "Text")
        textField.text = ""
        textField.font = .systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: "••••",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? .gray]
        )
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let viewEyeContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonEye: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseBackgroundColor = UIColor(named: "Background")
        config.image = UIImage(named: "eyeSlash")
        
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(EyeButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonNext: ButtonPrimary = {
        let button = ButtonPrimary()
        button.addTarget(self, action: #selector(NextButtonTapped(_:)), for: .touchUpInside)
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
        self.title = "Senha do cartão"
        
        self.textFieldPassword.delegate = self
        
        settingButton(isDisabled: true)
        
        buildHierarchy()
        buildConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    // MARK: - Actions
    @IBAction private func EyeButtonTapped(_ sender: UIButton) {
        self.isSecure = !self.isSecure
        self.textFieldPassword.isSecureTextEntry = self.isSecure
        
        if self.isSecure {
            self.buttonEye.configuration?.image = UIImage(named: "eyeSlash")
        }
        else {
            self.buttonEye.configuration?.image = UIImage(named: "eye")
        }
    }
    
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        guard let cardPint = self.textFieldPassword.text else {
            return
        }
        self.viewModel.setCardPin(cardPint)
        self.coordinatorDelegate?.goToCardTerm()
    }
    
    // MARK: - Methods
    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonNext.settingDisabled(true, text: "Digite uma senha")
            return
        }
        self.buttonNext.settingDisabled(false, text: "Avançar")
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
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelSection)
        stackContent.addArrangedSubview(labelSubText)
        
        stackContent.addArrangedSubview(viewStackTextFieldContainer)
        viewStackTextFieldContainer.addSubview(stackTextField)
        stackTextField.addArrangedSubview(textFieldPassword)
        stackTextField.addArrangedSubview(viewEyeContainer)
        viewEyeContainer.addSubview(buttonEye)
        
        stackBase.addArrangedSubview(buttonNext)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewStackTextFieldContainer.heightAnchor.constraint(equalToConstant: 20),
            stackTextField.centerXAnchor.constraint(equalTo: viewStackTextFieldContainer.centerXAnchor),
            stackTextField.centerXAnchor.constraint(equalTo: viewStackTextFieldContainer.centerXAnchor),
            
            textFieldPassword.widthAnchor.constraint(equalToConstant: 60),
            
            viewEyeContainer.widthAnchor.constraint(equalToConstant: 20),
            buttonEye.widthAnchor.constraint(equalToConstant: 20),
            buttonEye.heightAnchor.constraint(equalToConstant: 15),
            buttonEye.centerXAnchor.constraint(equalTo: viewEyeContainer.centerXAnchor),
            buttonEye.centerYAnchor.constraint(equalTo: viewEyeContainer.centerYAnchor),
        ])
    }
}

// MARK: - extension UITextFieldDelegate
extension CardPinViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if updatedString.count > 4 {
                return false
            }
            
            if updatedString.count == 3 {
                self.settingButton(isDisabled: true)
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: updatedString)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            if updatedString.count == 4 {
                self.settingButton(isDisabled: false)
            }
            
            return true
        }
        
        return true
    }
}
