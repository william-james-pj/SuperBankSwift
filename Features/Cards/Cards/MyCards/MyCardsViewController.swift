//
//  MyCardsViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class MyCardsViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelSection: UILabel = {
        let label = UILabel()
        label.text = "Meus Cartões"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableViewCards: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de cartões"
        setupVC()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        
        buildHierarchy()
        buildConstraints()
        setupTableView()
    }
    
    func setupTableView() {
        tableViewCards.delegate = self
        tableViewCards.dataSource = self
        tableViewCards.register(MyCardsTableViewCell.self, forCellReuseIdentifier: MyCardsTableViewCell.resuseIdentifier)
        tableViewCards.register(VirtualCardFooter.self, forHeaderFooterViewReuseIdentifier: VirtualCardFooter.resuseIdentifier)
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(viewLabelContainer)
        viewLabelContainer.addSubview(labelSection)
        stackBase.addArrangedSubview(tableViewCards)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewLabelContainer.heightAnchor.constraint(equalToConstant: 30),
            labelSection.leadingAnchor.constraint(equalTo: viewLabelContainer.leadingAnchor, constant: 16),
            labelSection.centerYAnchor.constraint(equalTo: viewLabelContainer.centerYAnchor),
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension MyCardsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 56
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: VirtualCardFooter.resuseIdentifier) as! VirtualCardFooter
        return view
    }
}

// MARK: - extension UITableViewDataSource
extension MyCardsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCardsTableViewCell.resuseIdentifier, for: indexPath) as! MyCardsTableViewCell
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Cartões físicos"
        }
        return "Cartões virtuais"
    }
}
