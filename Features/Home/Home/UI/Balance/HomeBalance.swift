//
//  HomeBalance.swift
//  Home
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

class HomeBalance: UIView {
    // MARK: - Constrants
    // MARK: - Variables
    private var currentValue: String = "0,00"
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func settingView(balance: Double) {
        self.currentValue = "\(balance)"
        self.collectionView.reloadData()
    }
    
    private func setupVC() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BalanceCollectionViewCell.self, forCellWithReuseIdentifier: BalanceCollectionViewCell.resuseIdentifier)
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(collectionView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - extension UICollectionViewDelegate
extension HomeBalance: UICollectionViewDelegate {
}

// MARK: - extension CollectionViewDataSource
extension HomeBalance: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BalanceCollectionViewCell.resuseIdentifier, for: indexPath) as! BalanceCollectionViewCell
        cell.settingCell(currentValue)
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension HomeBalance: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}


