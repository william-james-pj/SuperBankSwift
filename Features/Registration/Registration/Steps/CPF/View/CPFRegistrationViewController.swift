//
//  CPFRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 23/11/22.
//

import UIKit
import RxSwift

public class CPFRegistrationViewController: UIViewController {
    // MARK: - Constrants
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
        let attrString = NSMutableAttributedString(string: "Pedimos essa informação apenas por questões\nregulatórias. Não se preocupe, seus dados estão\nprotegidos aqui no SuperBank.")
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
    
    private let textFieldCPF: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "000.000.00-00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? UIColor.black]
        )
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
        settingLabeText()
        buildHierarchy()
        buildConstraints()
        
        self.finishedVerification.subscribe { e in
            self.settingLoadingButton(false)
            self.coordinatorDelegate?.goToBirthDate()
        }.disposed(by: disposeBag)
        
        self.textFieldCPF.delegate = self
        self.textFieldCPF.addTarget(self, action: #selector(formattedCPFMask(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Actions
    @IBAction private func GoButtonTapped(_ sender: UIButton) {
        Task {
            self.settingLoadingButton(true)
            let isValid = await self.viewModel.validateCPF(cpf)
            
            if isValid {
                self.finishedVerification.onNext("")
                return
            }
            
            self.settingLoadingButton(false)
            self.settingError(to: true)
        }
    }
    
    // MARK: - Methods
    private func settingLabeText() {
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
            self.labelErro.isHidden = false
            return
        }
        self.isError = false
        self.labelErro.isHidden = true
    }
    
    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonGo.configuration?.baseForegroundColor = .gray
            self.buttonGo.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonGo.setTitle("Digite o número do CPF", for: .normal)
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
            self.textFieldCPF.isEnabled = false
            self.buttonGo.isEnabled = false
            self.buttonGo.setTitle("", for: .normal)
            self.buttonGo.configuration?.showsActivityIndicator = true
            return
        }
        self.textFieldCPF.isEnabled = true
        self.buttonGo.configuration?.showsActivityIndicator = false
        self.settingButton(isDisabled: true)
        return
    }
    
    @objc private func formattedCPFMask(_ textField: UITextField){
        if let text = textField.text {
            let cleanCPF = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            self.cpf = cleanCPF
            let mask = "###.###.###-##"
            var result = ""
            var index = cleanCPF.startIndex
            for ch in mask where index < cleanCPF.endIndex {
                if ch == "#" {
                    result.append(cleanCPF[index])
                    index = cleanCPF.index(after: index)
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
        stackContent.addArrangedSubview(labelWelcome)
        stackContent.addArrangedSubview(labelTitle)
        stackContent.addArrangedSubview(labelInfo)
        stackContent.addArrangedSubview(textFieldCPF)
        stackContent.addArrangedSubview(labelErro)
        
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
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let updatedString = updatedString {
            if updatedString.count == 14 {
                self.validateInput(true)
            }
            else if updatedString.count > 14 {
                return false
            }
            else {
                self.validateInput(false)
            }
        }
        
        return true
    }
}

