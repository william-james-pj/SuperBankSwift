//
//  CardLockTableViewCell.swift
//  Cards
//
//  Created by Pinto Junior, William James on 21/12/22.
//

import UIKit
import Common

protocol CardLockTableViewCellDelegate: AnyObject {
    func switchValueChange(cardId: String, keyName: String, value: Bool)
}

class CardLockTableViewCell: UITableViewCell {
    // MARK: - Constraints
    static let reuseIdentifier: String = "CardLockTableViewCell"

    // MARK: - Variables
    private var cardLock: CardLockModel?

    private var isActiveAux: Bool = false
    private var cardId: String?
    private var keyName: String?

    weak var delegate: CardLockTableViewCellDelegate?

    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let viewTextContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelStatus: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var switchControl: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = UIColor(named: "Primary")
        switchView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchView
    }()

    private let viewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DisabledLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    }

    // MARK: - Actions
    @IBAction private func handleSwitchAction(_ sender: UIButton) {
        guard let cardId = cardId, let keyName = keyName else {
            return
        }

        self.isActiveAux = !isActiveAux
        self.settingStatus(isActiveAux)
        self.delegate?.switchValueChange(cardId: cardId, keyName: keyName, value: isActiveAux)
    }

    // MARK: - Methods
    func settingCell(_ cardLock: CardLockModel, cardId: String?) {
        self.cardLock = cardLock
        self.isActiveAux = cardLock.isActive
        self.cardId = cardId
        self.keyName = cardLock.keyName

        self.labelTitle.text = cardLock.title
        self.switchControl.isOn = !cardLock.isActive

        self.settingStatus(cardLock.isActive)
    }

    private func settingStatus(_ isActive: Bool) {
        guard let cardLock = cardLock else {
            return
        }

        if !isActive {
            self.labelStatus.text = cardLock.activeStatus
            return
        }
        self.labelStatus.text = cardLock.disabledStatus
    }

    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(viewTextContainer)
        viewTextContainer.addSubview(stackText)
        stackText.addArrangedSubview(labelTitle)
        stackText.addArrangedSubview(labelStatus)

        stackBase.addArrangedSubview(viewButtonContainer)
        viewButtonContainer.addSubview(switchControl)

        self.addSubview(viewSeparator)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackText.centerYAnchor.constraint(equalTo: viewTextContainer.centerYAnchor),
            stackText.leadingAnchor.constraint(equalTo: viewTextContainer.leadingAnchor),

            viewButtonContainer.widthAnchor.constraint(equalToConstant: 60),
            switchControl.centerXAnchor.constraint(equalTo: viewButtonContainer.centerXAnchor),
            switchControl.centerYAnchor.constraint(equalTo: viewButtonContainer.centerYAnchor),

            viewSeparator.heightAnchor.constraint(equalToConstant: 1),
            viewSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            viewSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viewSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
