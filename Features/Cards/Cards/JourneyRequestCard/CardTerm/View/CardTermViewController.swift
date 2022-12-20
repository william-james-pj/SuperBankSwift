//
//  CardTermViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 12/12/22.
//

import UIKit

public class CardTermViewController: UIViewController {
    // MARK: - Constrants
    private let terms: [CardTermModel] = [CardTermModel(title: "Contrato do cartão", subTitle: "Não há cobrança de anuidade")]
    
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelSection: UILabel = {
        let attrString = NSMutableAttributedString(string: "Assinatura dos Contratos")
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
    
    private let tableViewTerms: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let viewTerm: CheckTerm = {
        let view = CheckTerm()
        view.settingView("Declaro que li e concordo com todos os\ntermos e contratos acima.")
        return view
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
        self.title = "Termos do contrato"
        
        self.viewTerm.delegate = self
        
        settingButtonNext(isDisabled: true)
        
        buildHierarchy()
        buildConstraints()
        setupTableView()
    }
    
    func setupTableView() {
        tableViewTerms.delegate = self
        tableViewTerms.dataSource = self
        tableViewTerms.register(CardTermTableViewCell.self, forCellReuseIdentifier: CardTermTableViewCell.resuseIdentifier)
    }
    
    // MARK: - Actions
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.goToRequestCardResume()
    }
    
    // MARK: - Methods
    private func settingButtonNext(isDisabled: Bool) {
        if isDisabled {
            self.buttonNext.settingDisabled(true, text: "Avançar")
            return
        }
        self.buttonNext.settingDisabled(false, text: "Avançar")
    }
    
    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackContent)
        stackContent.addArrangedSubview(labelSection)
        stackContent.addArrangedSubview(tableViewTerms)
        
        stackBase.addArrangedSubview(viewTerm)
        
        stackBase.addArrangedSubview(buttonNext)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension CardTermViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

// MARK: - extension UITableViewDataSource
extension CardTermViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.terms.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTermTableViewCell.resuseIdentifier, for: indexPath) as! CardTermTableViewCell
        cell.selectionStyle = .none
        cell.settingCell(self.terms[indexPath.row])
        return cell
    }
}

// MARK: - extension CheckTermDelegate
extension CardTermViewController: CheckTermDelegate {
    func buttonCheckPress(_ isChecked: Bool) {
        if isChecked {
            self.settingButtonNext(isDisabled: false)
            return
        }
        self.settingButtonNext(isDisabled: true)
    }
    
}
