//
//  RequestCardHomeTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import UIKit

protocol RequestCardHomeTableViewCellDelegate: AnyObject {
    func onPress()
}

class RequestCardHomeTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "RequestCardHomeTableViewCell"

    // MARK: - Variables
    weak var delegate: RequestCardHomeTableViewCellDelegate?

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

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
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
    private func setupView() {
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            RequestCardCollectionViewCell.self,
            forCellWithReuseIdentifier: RequestCardCollectionViewCell.reuseIdentifier
        )
    }

    // MARK: - Methods
    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(collectionView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - extension UICollectionViewDelegate
extension RequestCardHomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onPress()
    }
}

// MARK: - extension CollectionViewDataSource
extension RequestCardHomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RequestCardCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! RequestCardCollectionViewCell
        // swiftlint:enable force_cast
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension RequestCardHomeTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
