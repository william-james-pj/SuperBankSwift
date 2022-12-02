//
//  HomeViewController.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class HomeViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?
    
    // MARK: - Components
    fileprivate let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    fileprivate let viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.text = "Joãozinho"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let header: HomeHeader = {
        let view = HomeHeader()
        return view
    }()
    
    fileprivate let balance: HomeBalance = {
        let view = HomeBalance()
        view.currentValue = "10,823.53"
        return view
    }()
    
    fileprivate let options: HomeOptions = {
        let view = HomeOptions()
        view.options = [.pix, .transfer, .pay, .card, .edit]
        return view
    }()
    
    fileprivate let creditCard: HomeCreditCard = {
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
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        
        self.options.delegate = self
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(stackBase)
        
        stackBase.addArrangedSubview(header)
        stackBase.addArrangedSubview(balance)
        stackBase.addArrangedSubview(options)
        stackBase.addArrangedSubview(creditCard)
    }
    
    fileprivate func buildConstraints() {
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
            break
        case .edit:
            break
        }
    }
}
