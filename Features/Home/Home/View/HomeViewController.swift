//
//  HomeViewController.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class HomeViewController: UIViewController {
    // MARK: - Constrants
    private let viewModel = HomeViewModel()
    
    // MARK: - Variables
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?
    
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
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.text = "Joãozinho"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let header: HomeHeader = {
        let view = HomeHeader()
        return view
    }()
    
    private let balance: HomeBalance = {
        let view = HomeBalance()
        return view
    }()
    
    private let options: HomeOptions = {
        let view = HomeOptions()
        view.options = [.pix, .transfer, .pay, .card, .edit]
        return view
    }()
    
    private let requestCard: RequestCard = {
        let view = RequestCard()
        return view
    }()
    
    private let creditCard: HomeCreditCard = {
        let view = HomeCreditCard()
        return view
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
        self.header.delegate = self
        self.options.delegate = self
        self.requestCard.delegate = self
        
        settingClosures()
        
        self.viewModel.getMoneyIsHide()
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    public func loaderData(customerId: String, accountId: String) {
        Task {
            await self.viewModel.getData(customerId: customerId, accountId: accountId)
        }
    }
    
    private func settingClosures() {
        self.viewModel.updateCustomerUI = { customer in
            DispatchQueue.main.async {
                self.header.settingView(fullName: customer.fullName)
            }
        }
        
        self.viewModel.updateAccountUI = { account in
            self.balance.settingView(balance: account.balance)
        }
        
        self.viewModel.updateHideMoney = { isHide in
            self.balance.settingHide(to: isHide)
            self.header.settingMoneyIsHide(to: isHide)
        }
    }
    
    private func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(stackBase)
        
        stackBase.addArrangedSubview(header)
        stackBase.addArrangedSubview(balance)
        stackBase.addArrangedSubview(options)
        stackBase.addArrangedSubview(requestCard)
//        stackBase.addArrangedSubview(creditCard)
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
        ])
    }
}

// MARK: - extension HomeHeaderDelegate
extension HomeViewController: HomeHeaderDelegate {
    func setMoneyHide(to isHide: Bool) {
        self.viewModel.setMoneyIsHide(to: isHide)
    }
    
    func openDrawerMenu() {
        self.coordinatorDelegate?.goToDrawerMenu()
    }
}

// MARK: - extension HomeOptionsDelegate
extension HomeViewController: HomeOptionsDelegate {
    func onPress(option: OptionType) {
        switch option {
        case .pix:
            break
        case .transfer:
            break
        case .pay:
            break
        case .card:
            self.coordinatorDelegate?.goToPresentCard()
        case .edit:
            break
        }
    }
}

// MARK: - extension RequestCardDelegate
extension HomeViewController: RequestCardDelegate {
    func onPress() {
        self.coordinatorDelegate?.goToPresentCard()
    }
}
