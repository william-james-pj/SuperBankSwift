//
//  InvoiceDueDateViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import UIKit
import RxSwift

public class InvoiceDueDateViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = JourneyRequestCardViewModel.sharedJourneyRequestCard
    let dueDates = ["2", "4", "15", "25", "27"]
    let disposeBag = DisposeBag()
    
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    var invoiceDueDate: String?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
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
    
    private let labelSection: UILabel = {
        let attrString = NSMutableAttributedString(string: "Selecione o vencimento da fatura")
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
    
    private let viewChooseDuewDate: ChooseDueDate = {
        let view = ChooseDueDate()
        return view
    }()
    
    private let buttonNext: RequestCardButton = {
        let button = RequestCardButton()
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
        self.title = "Vencimento da Fatura"
        
        settingButton(isDisabled: true)
        
        viewChooseDuewDate.setButtonTitles(self.dueDates)
        viewChooseDuewDate.didSelectDueDate.subscribe(onNext: {
            self.invoiceDueDate = $0
            self.settingButton(isDisabled: false)
        }).disposed(by: disposeBag)
        
        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Actions
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        guard let invoiceDueDate = invoiceDueDate else {
            return
        }

        self.viewModel.setInvoiceDueDate(invoiceDueDate)
        self.coordinatorDelegate?.goToCardPin()
    }
    
    // MARK: - Methods
    private func settingButton(isDisabled: Bool) {
        if isDisabled {
            self.buttonNext.settingDisabled(true, text: "Selecione o vencimento")
            return
        }
        self.buttonNext.settingDisabled(false, text: "Avançar")
    }
    
    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(labelSection)
        stackBase.addArrangedSubview(viewChooseDuewDate)
        stackBase.addArrangedSubview(viewStackAux)
        
        view.addSubview(buttonNext)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            buttonNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
