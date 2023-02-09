//
//  CreditLimitViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 09/12/22.
//

import UIKit
import Common

public class CreditLimitViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = JourneyRequestCardViewModel.sharedJourneyRequestCard

    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    private var slideCurrentValue: Double = 0

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
        let attrString = NSMutableAttributedString(string: "Selecione o valor desejado")
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

    private let labelSubText: UILabel = {
        let attrString = NSMutableAttributedString(string: "R$ 0,00 disponivel para uso.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewTextFieldContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textFieldCreditValue: UITextField = {
        let textField = UITextField()
        textField.text = "RS 5.000,00"
        textField.textColor = UIColor(named: "Text")
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        textField.textAlignment = .center
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let stackSlide: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stackSlideHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelMinValue: UILabel = {
        let label = UILabel()
        label.text = "100.0"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelMaxValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sliderBar: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor(named: "Primary")
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private lazy var buttonNext: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("Avançar")
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
        self.title = "Ajuste de Limite"
        self.textFieldCreditValue.addBottomBorder(color: UIColor(named: "Disabled"), height: 1)

        settingButton(isDisabled: true)
        settingCreditValue()

        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Actions
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        let step = Float(100)
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        self.slideCurrentValue = Double(roundedStepValue)
        self.textFieldCreditValue.text = self.viewModel.formatCurrency(Double(roundedStepValue))
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        self.viewModel.setCreditValue(self.slideCurrentValue)
        self.coordinatorDelegate?.goToInvoiceDueDate()
    }

    // MARK: - Methods
    private func settingCreditValue() {
        let value = self.viewModel.generationCreditValue()
        let textFormatted = self.viewModel.formatCurrency(value)

        self.labelSubText.text = "\(textFormatted) disponivel para uso."
        self.textFieldCreditValue.text = textFormatted
        self.labelMaxValue.text = "\(value)"

        self.sliderBar.maximumValue = Float(value)
        self.sliderBar.minimumValue = 100
        self.sliderBar.value = Float(value)
        self.slideCurrentValue = value

        if value > 100 {
            self.settingButton(isDisabled: false)
        }
    }

    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonNext.configuration?.baseForegroundColor = .gray
            self.buttonNext.configuration?.baseBackgroundColor = UIColor(named: "DisabledLight")
            self.buttonNext.isEnabled = false
            return
        }
        self.buttonNext.configuration?.baseForegroundColor = UIColor(named: "White")
        self.buttonNext.configuration?.baseBackgroundColor = UIColor(named: "Primary")
        self.buttonNext.isEnabled = true
    }

    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelSection)
        stackContent.addArrangedSubview(labelSubText)
        stackContent.addArrangedSubview(viewTextFieldContainer)
        viewTextFieldContainer.addSubview(textFieldCreditValue)

        stackContent.addArrangedSubview(stackSlide)
        stackSlide.addArrangedSubview(stackSlideHeader)
        stackSlideHeader.addArrangedSubview(labelMinValue)
        stackSlideHeader.addArrangedSubview(labelMaxValue)
        stackSlide.addArrangedSubview(sliderBar)

        stackBase.addArrangedSubview(buttonNext)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            viewTextFieldContainer.heightAnchor.constraint(equalToConstant: 40),
            textFieldCreditValue.heightAnchor.constraint(equalToConstant: 40),
            textFieldCreditValue.centerXAnchor.constraint(equalTo: viewTextFieldContainer.centerXAnchor),
            textFieldCreditValue.centerYAnchor.constraint(equalTo: viewTextFieldContainer.centerYAnchor)
        ])
    }
}
