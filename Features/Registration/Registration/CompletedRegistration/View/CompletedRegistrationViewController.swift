//
//  CompletedRegistrationViewController.swift
//  Registration
//
//  Created by Pinto Junior, William James on 24/11/22.
//

import UIKit
import Common

public class CompletedRegistrationViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = RegistrationViewModel.sharedRegistration

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

    private let stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
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
        imageView.image = UIImage(named: "happy")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.text = "Bem-vindo ao SuperBank!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelAccountOpened: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.text = "Acesse sua conta usando os dados abaixo"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackInfoBox: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let infoBoxCode: InfoBox = {
        let view = InfoBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoBoxPassword: InfoBox = {
        let view = InfoBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var buttonGo: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("Acessar sua conta")
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
        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Actions
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.didFinishRegistration()
    }

    // MARK: - Methods
    public func settingVC(login: LoginModel) {
        self.infoBoxCode.settingView("Código de Cliente", login.accountNumber)
        self.infoBoxPassword.settingView("Senha inicial", login.password)
    }

    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelTitle)

        stackContent.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewInfo)

        stackContent.addArrangedSubview(labelAccountOpened)

        stackContent.addArrangedSubview(stackInfoBox)
        stackInfoBox.addArrangedSubview(infoBoxCode)
        stackInfoBox.addArrangedSubview(infoBoxPassword)

        stackBase.addArrangedSubview(buttonGo)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            viewImageContainer.heightAnchor.constraint(equalToConstant: 200),

            imageViewInfo.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageViewInfo.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor),
            imageViewInfo.widthAnchor.constraint(equalToConstant: 138),
            imageViewInfo.heightAnchor.constraint(equalToConstant: 157)
        ])
    }
}
