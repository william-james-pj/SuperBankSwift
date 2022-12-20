//
//  OptionsHomeTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit

protocol OptionsHomeTableViewCellDelegate {
    func onPress(option: OptionHomeType)
}

class OptionsHomeTableViewCell: UITableViewCell {
    // MARK: - Constrants
    static let resuseIdentifier: String = "OptionsHomeTableViewCell"

    // MARK: - Variables
    var options: [OptionHomeType] = []
    var delegate: OptionsHomeTableViewCellDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelSection: UILabel = {
        let label = UILabel()
        label.text = "Seus atalhos"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Setup
    private func setupCell() {
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(OptionHomeCollectionViewCell.self, forCellWithReuseIdentifier: OptionHomeCollectionViewCell.resuseIdentifier)
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(labelSection)
        
        stackBase.addArrangedSubview(collectionView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}

// MARK: - extension UICollectionViewDelegate
extension OptionsHomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onPress(option: options[indexPath.row])
    }
}

// MARK: - extension CollectionViewDataSource
extension OptionsHomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionHomeCollectionViewCell.resuseIdentifier, for: indexPath) as! OptionHomeCollectionViewCell
        cell.settingCell(options[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension OptionsHomeTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: 60, height: height)
    }
}
