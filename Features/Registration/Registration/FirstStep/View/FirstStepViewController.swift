//
//  FirstStepViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common

public class FirstStepViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    
    // MARK: - Components
    fileprivate let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackScrollView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Precisamos de alguns\ndados pessoais.")
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
    
    fileprivate let textFieldName: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Nome completo",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate let textFieldCPF: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu CPF",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate let textFieldBirthDate: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Data de nascimento",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate let textFieldEmail: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Qual o seu e-mail?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    fileprivate let textFieldRepeatEmail: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Confirme seu e-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    fileprivate let textFieldPhoneNumber: UITextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Telefone celular",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        )
        textField.keyboardType = UIKeyboardType.phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate let labelAgreeTerms: UITextView = {
        let attrString = NSMutableAttributedString(string: "Ao cliclar em \"Avança\" e continuar com o seu cadastro, você autoriza o SuperBank a coletar seus dados pessoais de acordo com a nossa Política de Privacidade, com o objetivo de comunicar informações sobre o proccesso de abertura da sua conta")
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

    
    fileprivate let buttonOpenAccount: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.buttonSize = .large
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("Avança", attributes: container)
        
        let button = UIButton()
        button.configuration = config
//        button.addTarget(self, action: #selector(AccontbuttonTapped(_:)), for: .touchUpInside)
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
        setTextWithLink()
        settingTextFields()
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func settingTextFields() {
        self.textFieldCPF.delegate = self
        self.textFieldCPF.addTarget(self, action: #selector(formattedCPFMask(_:)), for: .editingChanged)
        
        self.textFieldBirthDate.delegate = self
        self.textFieldBirthDate.addTarget(self, action: #selector(formattedBirthDate(_:)), for: .editingChanged)
        
        self.textFieldPhoneNumber.delegate = self
        self.textFieldPhoneNumber.addTarget(self, action: #selector(formattedPhoneNumber(_:)), for: .editingChanged)
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
    
    @objc fileprivate func formattedCPFMask(_ textField: UITextField){
        let cleanPhoneNumber = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "###.###.###-##"
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
    
    @objc fileprivate func formattedBirthDate(_ textField: UITextField){
        let cleanPhoneNumber = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##/##/####"
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
    
    @objc fileprivate func formattedPhoneNumber(_ textField: UITextField){
        let cleanPhoneNumber = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) ##### ####"
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
    
    fileprivate func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackScrollView)
        stackScrollView.addArrangedSubview(labelTitle)
        
        stackScrollView.addArrangedSubview(textFieldName)
        stackScrollView.addArrangedSubview(textFieldCPF)
        stackScrollView.addArrangedSubview(textFieldBirthDate)
        stackScrollView.addArrangedSubview(textFieldEmail)
        stackScrollView.addArrangedSubview(textFieldRepeatEmail)
        stackScrollView.addArrangedSubview(textFieldPhoneNumber)
        
        stackScrollView.addArrangedSubview(labelAgreeTerms)
        
        stackScrollView.addArrangedSubview(buttonOpenAccount)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            textFieldName.heightAnchor.constraint(equalToConstant: 55),
            textFieldCPF.heightAnchor.constraint(equalToConstant: 55),
            textFieldBirthDate.heightAnchor.constraint(equalToConstant: 55),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 55),
            textFieldRepeatEmail.heightAnchor.constraint(equalToConstant: 55),
            textFieldPhoneNumber.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

extension FirstStepViewController: UITextFieldDelegate {
    
}
