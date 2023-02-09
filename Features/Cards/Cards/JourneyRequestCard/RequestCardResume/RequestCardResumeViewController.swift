//
//  RequestCardResumeViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 12/12/22.
//

import UIKit

public class RequestCardResumeViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = JourneyRequestCardViewModel.sharedJourneyRequestCard

    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?

    private var creditLimit: String = ""
    private var dueDate: String = ""

    // MARK: - Components
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 40
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelSection: UILabel = {
        let attrString = NSMutableAttributedString(string: "Resumo da solicitação")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelInfo: UILabel = {
        let attrString = NSMutableAttributedString(
            string: """
                    Confira os dados do seu novo cartão. Ao cliclar em
                    \"Validar e Confirmar\", sua solicitação será confirmada.
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

    private let stackConfig: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelConfig: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.text = "Configuração do cartão"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func labelRowTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func labelRowText(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func viewLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])

        return view
    }

    private func stackRowLimit() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.addArrangedSubview(labelRowTitle("Limite"))
        stack.addArrangedSubview(labelRowText(self.creditLimit))
        return stack
    }

    private func stackRowDueDate() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.addArrangedSubview(labelRowTitle("Vencimento"))
        stack.addArrangedSubview(labelRowText(self.dueDate))
        return stack
    }

    private func stackRowPassword() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.addArrangedSubview(labelRowTitle("Senha"))
        stack.addArrangedSubview(labelRowText("••••"))
        return stack
    }

    private let viewDeliveryBorder: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "DisabledLight")?.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackDelivery: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelWarning: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.text = "Atenção"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelInfoDelivery: UILabel = {
        let attrString = NSMutableAttributedString(
            string: """
                    Seu cartão será entregue em até 10 dias.\nÉ importante ter
                    alguem para recebê-lo no endereço indicado.
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

    private let stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let viewTerm: CheckTerm = {
        let view = CheckTerm()
        view.settingView("Confirmo que os dados estão atualizados")
        return view
    }()

    private lazy var buttonNext: ButtonPrimary = {
        let button = ButtonPrimary()
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
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
        self.title = "Resumo"

        self.viewTerm.delegate = self

        settingButtonNext(isDisabled: true)

        self.creditLimit = self.viewModel.getCreditValue()
        self.dueDate = self.viewModel.getDueDate()

        self.viewModel.finishSavingInvoice = {
            DispatchQueue.main.async {
                self.buttonNext.settingLoading(false)
                self.coordinatorDelegate?.goToCompletedRequestCard()
            }
        }

        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Actions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        self.buttonNext.settingLoading(true)
        self.loaderData()
    }

    // MARK: - Methods
    public func settingAccountId(_ accountId: String?) {
        guard let accountId = accountId else {
            return
        }
        self.viewModel.setAccountId(accountId)
    }

    private func loaderData() {
        Task {
            await self.viewModel.createInvoice()
        }
    }

    private func settingButtonNext(isDisabled: Bool) {
        if isDisabled {
            self.buttonNext.settingDisabled(true, text: "Validar e Confirmar")
            return
        }
        self.buttonNext.settingDisabled(false, text: "Validar e Confirmar")
    }

    private func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(stackBase)

        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(labelSection)
        stackHeader.addArrangedSubview(labelInfo)

        stackBase.addArrangedSubview(stackConfig)
        stackConfig.addArrangedSubview(labelConfig)
        stackConfig.addArrangedSubview(stackRowLimit())
        stackConfig.addArrangedSubview(viewLine())
        stackConfig.addArrangedSubview(stackRowDueDate())
        stackConfig.addArrangedSubview(viewLine())
        stackConfig.addArrangedSubview(stackRowPassword())
        stackConfig.addArrangedSubview(viewLine())

        stackBase.addArrangedSubview(viewDeliveryBorder)
        viewDeliveryBorder.addSubview(stackDelivery)
        stackDelivery.addArrangedSubview(labelWarning)
        stackDelivery.addArrangedSubview(labelInfoDelivery)

        stackBase.addArrangedSubview(stackButton)
        stackButton.addArrangedSubview(viewTerm)
        stackButton.addArrangedSubview(buttonNext)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackBase.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor),

            stackDelivery.topAnchor.constraint(equalTo: viewDeliveryBorder.topAnchor, constant: 16),
            stackDelivery.leadingAnchor.constraint(equalTo: viewDeliveryBorder.leadingAnchor, constant: 16),
            stackDelivery.trailingAnchor.constraint(equalTo: viewDeliveryBorder.trailingAnchor, constant: -16),
            stackDelivery.bottomAnchor.constraint(equalTo: viewDeliveryBorder.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - extension CheckTermDelegate
extension RequestCardResumeViewController: CheckTermDelegate {
    func buttonCheckPress(_ isChecked: Bool) {
        if isChecked {
            self.settingButtonNext(isDisabled: false)
            return
        }
        self.settingButtonNext(isDisabled: true)
    }
}
