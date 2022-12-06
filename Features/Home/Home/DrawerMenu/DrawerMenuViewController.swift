//
//  DrawerMenuViewController.swift
//  Home
//
//  Created by Pinto Junior, William James on 05/12/22.
//

import UIKit

public class DrawerMenuViewController: UIViewController {
    // MARK: - Constrants
    private let items: [DrawerTableViewCellType] = [.profile, .logoff]
    // MARK: - Variables
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?
    
    // MARK: - Components
    private let tableView: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let header: DrawerHeader = {
        let view = DrawerHeader()
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
        
        setupTableView()
        buildHierarchy()
        buildConstraints()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DrawerTableViewCell.self, forCellReuseIdentifier: DrawerTableViewCell.resuseIdentifier)
        tableView.register(DrawerHeader.self, forHeaderFooterViewReuseIdentifier: DrawerHeader.resuseIdentifier)
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - extension UITableViewDelegate
extension DrawerMenuViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: DrawerHeader.resuseIdentifier) as! DrawerHeader
        view.delegate = self
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aux = self.items[indexPath.row]
        switch aux {
        case .profile:
            break
        case .logoff:
            print("BB")
        }
    }
}

// MARK: - extension UITableViewDataSource
extension DrawerMenuViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrawerTableViewCell.resuseIdentifier, for: indexPath) as! DrawerTableViewCell
        cell.settingCell(items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - extension DrawerHeaderDelegate
extension DrawerMenuViewController: DrawerHeaderDelegate {
    func closeDrawer() {
        self.coordinatorDelegate?.closeDrawerMenu()
    }
}
