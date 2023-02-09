//
//  HomeViewController.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit
import Common

public class HomeViewController: UIViewController {
    // MARK: - Constraints
    private let viewModel = HomeViewModel()
    private let refreshControl = UIRefreshControl()

    // MARK: - Variables
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?

    private var fullName: String = ""
    private var balance: Double = 0
    private var accountHasCard: Bool = false
    private var moneyIsHide: Bool = false
    private var isLoading: Bool = true

    private var accountHasCardDelivery = false
    private var cardDelivery: CardDeliveryModel?

    // MARK: - Components
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")

        settingClosures()
        self.viewModel.getMoneyIsHide()

        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "Primary")

        setupTableView()
        buildHierarchy()
        buildConstraints()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(
            HeaderHomeTableViewCell.self,
            forCellReuseIdentifier: HeaderHomeTableViewCell.reuseIdentifier
        )
        tableView.register(
            BalanceHomeTableViewCell.self,
            forCellReuseIdentifier: BalanceHomeTableViewCell.reuseIdentifier
        )
        tableView.register(
            OptionsHomeTableViewCell.self,
            forCellReuseIdentifier: OptionsHomeTableViewCell.reuseIdentifier
        )
        tableView.register(
            CardDeliveryTableViewCell.self,
            forCellReuseIdentifier: CardDeliveryTableViewCell.reuseIdentifier
        )
        tableView.register(
            RequestCardHomeTableViewCell.self,
            forCellReuseIdentifier: RequestCardHomeTableViewCell.reuseIdentifier
        )
        tableView.register(
            CreditInvoiceHomeTableViewCell.self,
            forCellReuseIdentifier: CreditInvoiceHomeTableViewCell.reuseIdentifier
        )
    }

    // MARK: - Actions
    @objc private func refreshData(_ sender: Any) {
        Task {
            await self.viewModel.reloadAccount()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }

    // MARK: - Methods
    public func loaderData(customerId: String, accountId: String) {
        Task {
            await self.viewModel.getData(customerId: customerId, accountId: accountId)
        }
    }

    public func reloadTableHome() {
        Task {
            await self.viewModel.reloadAccount()
        }
    }

    private func settingClosures() {
        self.viewModel.updateCustomerUI = { customer in
            DispatchQueue.main.async {
                self.fullName = customer.fullName
                self.tableView.reloadData()
            }
        }

        self.viewModel.updateAccountUI = { account in
            DispatchQueue.main.async {
                self.balance = account.balance
                self.accountHasCard = account.hasCard
                self.accountHasCardDelivery = account.hasCardDelivery
                self.isLoading = false
                self.tableView.reloadData()
            }
        }

        self.viewModel.updateHideMoney = { isHide in
            self.moneyIsHide = isHide
            self.tableView.reloadData()
        }

        self.viewModel.updateCardDelivery = { cardDelivery in
            DispatchQueue.main.async {
                self.cardDelivery = cardDelivery
                self.tableView.reloadData()
            }
        }
    }

    private func buildHierarchy() {
        view.addSubview(tableView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
}

// MARK: - extension UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    // Sections
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        default:
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 3: // CardDelivery
            if accountHasCardDelivery {
                let headerView = UIView()
                headerView.backgroundColor = UIColor.clear
                return headerView
            }
            return nil
        default:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    // Cells
    // swiftlint:disable force_cast
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Header
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderHomeTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! HeaderHomeTableViewCell
            cell.settingView(fullName: self.fullName)
            cell.settingMoneyIsHide(to: self.moneyIsHide)
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 1: // Balance
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BalanceHomeTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! BalanceHomeTableViewCell
            cell.settingCell("\(self.balance)", isHide: self.moneyIsHide)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 2: // Options
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OptionsHomeTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! OptionsHomeTableViewCell
            cell.options = [.pix, .transfer, .pay, .card, .edit]
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 3: // CardDelivery
            if accountHasCardDelivery {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CardDeliveryTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as! CardDeliveryTableViewCell
                cell.settingCell(cardDelivery)
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.isHidden = true
            return cell
        case 4: // RequestCard and CreditInvoice
            if accountHasCard {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CreditInvoiceHomeTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as! CreditInvoiceHomeTableViewCell
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            }

            let cell = tableView.dequeueReusableCell(
                withIdentifier: RequestCardHomeTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! RequestCardHomeTableViewCell
            cell.delegate = self
            cell.isHidden = self.isLoading
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = .brown
            return cell
        }
    }
    // swiftlint:enable force_cast

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: // Header
            return 40
        case 1: // Balance
            return 45
        case 2: // Options
            return 120
        case 3: // CardDelivery
            if accountHasCardDelivery {
                return 135
            }
            return 0
        case 4: // RequestCard and CreditInvoice
            if accountHasCard {
                return 92
            }
            return 86
        default:
            return 60.0
        }
    }
}

// MARK: - extension HomeHeaderDelegate
extension HomeViewController: HeaderHomeTableViewCellDelegate {
    func setMoneyHide(to isHide: Bool) {
        self.viewModel.setMoneyIsHide(to: isHide)
    }

    func openDrawerMenu() {
        self.coordinatorDelegate?.goToDrawerMenu(customerName: fullName)
    }
}

// MARK: - extension HomeOptionsDelegate
extension HomeViewController: OptionsHomeTableViewCellDelegate {
    func onPress(option: OptionHomeType) {
        switch option {
        case .pix:
            break
        case .transfer:
            break
        case .pay:
            break
        case .card:
            self.coordinatorDelegate?.goToCard(hasCard: accountHasCard)
        case .edit:
            break
        }
    }
}

// MARK: - extension RequestCardDelegate
extension HomeViewController: RequestCardHomeTableViewCellDelegate {
    func onPress() {
        self.coordinatorDelegate?.goToCard(hasCard: false)
    }
}
