//
//  FirstInfoViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class FirstInfoViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: RegistrationCoordinatorDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewInfo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registrationInfo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelOpenAccount: UILabel = {
        let attrString = NSMutableAttributedString(string: "Abra sua conta\ngratuitamente")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelStart: UILabel = {
        let attrString = NSMutableAttributedString(string: "Você está preste a dar o primeiro passo em\nbusca da evolução financeira!.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDocument: UILabel = {
        let attrString = NSMutableAttributedString(string: "Para facilitar seu cadrastro, tenha em mãos um dos\nseus documentos de identidade: RG, CNH ou RNE.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonOpenAccount: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("ABRIR CONTA")
        button.addTarget(self, action: #selector(OpenAccountButtonTapped(_:)), for: .touchUpInside)
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
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    @IBAction private func OpenAccountButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.goToFullName()
    }
    
    private func buildHierarchy() {
        view.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewInfo)
        stackText.addArrangedSubview(labelOpenAccount)
        stackText.addArrangedSubview(labelStart)
        stackText.addArrangedSubview(labelDocument)
        
        stackBase.addArrangedSubview(buttonOpenAccount)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewImageContainer.heightAnchor.constraint(equalToConstant: 240),
            
            imageViewInfo.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageViewInfo.bottomAnchor.constraint(equalTo: viewImageContainer.bottomAnchor, constant: -16),
            imageViewInfo.widthAnchor.constraint(equalToConstant: 140),
            imageViewInfo.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
}

