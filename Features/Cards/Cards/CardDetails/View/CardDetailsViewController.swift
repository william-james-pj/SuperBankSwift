//
//  CardDetailsViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 21/12/22.
//

import UIKit
import Common

public protocol CardDetailsVCDelegate {
    func reloadCards()
}

public class CardDetailsViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = CardDetailsViewModel()
    
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    public var delegate: CardDetailsVCDelegate?
    public var card: CardModel? {
        didSet {
            settingTitle()
            settingCardLock()
        }
    }
    private var cardLocks: [CardLockModel] = []

    // MARK: - Components
    private let tableView: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let viewShadow: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = UIColor(named: "Primary")
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        
        settingClosures()
        
        buildHierarchy()
        buildConstraints()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(CardLockTableViewCell.self, forCellReuseIdentifier: CardLockTableViewCell.resuseIdentifier)
        tableView.register(CardDetailsHeader.self, forHeaderFooterViewReuseIdentifier: CardDetailsHeader.resuseIdentifier)
    }
    
    // MARK: - Methods
    private func settingTitle() {
        guard let card = card else {
            return
        }
        
        if card.cardType == .physical {
            self.title = "Cartão físico"
            return
        }
        self.title = "Cartão digital"
    }
    
    private func settingCardLock() {
        guard let card = card else {
            return
        }

        let obj1 = CardLockModel(title: "Bloqueiro temporário", keyName: "isEnabled", activeStatus: "Bloqueado", disabledStatus: "Desbloqueado", isActive: card.isEnabled)
        let obj2 = CardLockModel(title: "Compras internacionais", keyName: "isInternationPurchasesEnabled", activeStatus: "Bloqueadas", disabledStatus: "Desbloqueadas", isActive: card.isInternationPurchasesEnabled)
        
        self.cardLocks = [obj1, obj2]
    }
    
    private func settingClosures() {
        self.viewModel.finishUpdateCard = {
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.viewShadow.isHidden = true
                self.delegate?.reloadCards()
            }
        }
    }
    
    private func buildHierarchy() {
        view.addSubview(tableView)
        view.addSubview(viewShadow)
        viewShadow.addSubview(indicatorView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewShadow.topAnchor.constraint(equalTo: view.topAnchor),
            viewShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewShadow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicatorView.centerXAnchor.constraint(equalTo: viewShadow.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: viewShadow.centerYAnchor),
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension CardDetailsViewController: UITableViewDelegate {
}

// MARK: - extension UITableViewDataSource
extension CardDetailsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Bloqueiros do cartão"
        default:
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return cardLocks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { 
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardLockTableViewCell.resuseIdentifier, for: indexPath) as! CardLockTableViewCell
        cell.settingCell(self.cardLocks[indexPath.row], cardId: self.card?.cardId)
        cell.delegate = self
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 16
        }
        
        return 70.0
    }
    
    // header
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 217.0
        }
        return 20
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CardDetailsHeader.resuseIdentifier) as! CardDetailsHeader
            view.settingView(card)
            return view
        }
        return nil
    }
}

// MARK: - extension CardLockTableViewCellDelegate
extension CardDetailsViewController: CardLockTableViewCellDelegate {
    func switchValueChange(cardId: String, keyName: String, value: Bool) {
        self.viewShadow.isHidden = false
        self.indicatorView.startAnimating()
        
        if let header = self.tableView.headerView(forSection: 0) as? CardDetailsHeader {
            header.settingShadowCard(value)
        }
        
        Task {
            await self.viewModel.updateBlockerCard(cardId: cardId, keyName: keyName, value: value)
        }
    }
}
