//
//  DrawerMenuViewController.swift
//  Home
//
//  Created by Pinto Junior, William James on 05/12/22.
//

import UIKit

public class DrawerMenuViewController: UIViewController {
    // MARK: - Constraints
    private let items: [DrawerTableViewCellType] = [.profile, .logoff]

    // MARK: - Variables
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?
    public var customerName: String?

    // MARK: - Components
    private let tableView: UITableView = {
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
        setupVC()
    }

    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")

        setupTableView()
        buildHierarchy()
        buildConstraints()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DrawerTableViewCell.self, forCellReuseIdentifier: DrawerTableViewCell.reuseIdentifier)
        tableView.register(DrawerHeader.self, forHeaderFooterViewReuseIdentifier: DrawerHeader.reuseIdentifier)
    }

    // MARK: - Methods
    private func buildHierarchy() {
        view.addSubview(tableView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension DrawerMenuViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // swiftlint:disable force_cast
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: DrawerHeader.reuseIdentifier
        ) as! DrawerHeader
        // swiftlint:enable force_cast
        view.settingView(customerName: customerName)
        view.delegate = self
        return view
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aux = self.items[indexPath.row]
        switch aux {
        case .profile:
            break
        case .logoff:
            self.coordinatorDelegate?.closeDrawerMenu()
            self.coordinatorDelegate?.logoff()
        }
    }
}

// MARK: - extension UITableViewDataSource
extension DrawerMenuViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DrawerTableViewCell.reuseIdentifier, for: indexPath
        ) as! DrawerTableViewCell
        // swiftlint:enable force_cast
        cell.settingCell(items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

// MARK: - extension DrawerHeaderDelegate
extension DrawerMenuViewController: DrawerHeaderDelegate {
    func closeDrawer() {
        self.coordinatorDelegate?.closeDrawerMenu()
    }
}
