//
//  CardDetailsHeader.swift
//  Cards
//
//  Created by Pinto Junior, William James on 21/12/22.
//

import UIKit
import Common

class CardDetailsHeader: UITableViewHeaderFooterView {
    // MARK: - Constrants
    static let resuseIdentifier: String = "DrawerHeader"
    
    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelCardNickname: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func labelInfoTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func labelInfoText(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func stackCard() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private let stackCardRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 40
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewStackCardRowAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewShadowCard: UIView = {
        let view = UIView()
        view.isHidden = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewBall: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Primary")
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewLockCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lock-card")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingView(_ card: CardModel?) {
        guard let card = card else {
            return
        }
        
        if !card.isEnabled {
            self.viewShadowCard.isHidden = false
        }
        
        var name = card.cardName
        var number = formattedNumber(card.cardNumber)
        var expireDate = card.expireDate
        var cvc = card.cvc
        
        if card.cardType == .physical {
            name = "••••••••"
            number = "•••• •••• •••• \(number.suffix(4))"
            expireDate = "•••••"
            cvc = "•••"
        }
        
        self.labelCardNickname.text = card.nickname
        
        let stackName = stackCard()
        stackName.addArrangedSubview(labelInfoTitle("Nome"))
        stackName.addArrangedSubview(labelInfoText(name))
        
        let stackNumber = stackCard()
        stackNumber.addArrangedSubview(labelInfoTitle("Número"))
        stackNumber.addArrangedSubview(labelInfoText(number))
        
        let stackExpireDate = stackCard()
        stackExpireDate.addArrangedSubview(labelInfoTitle("Validade"))
        stackExpireDate.addArrangedSubview(labelInfoText(expireDate))
        
        let stackCVC = stackCard()
        stackCVC.addArrangedSubview(labelInfoTitle("CVC"))
        stackCVC.addArrangedSubview(labelInfoText(cvc))
        
        stackBase.addArrangedSubview(stackName)
        stackBase.addArrangedSubview(stackNumber)
        stackBase.addArrangedSubview(stackCardRow)
        stackCardRow.addArrangedSubview(stackExpireDate)
        stackCardRow.addArrangedSubview(stackCVC)
        stackCardRow.addArrangedSubview(viewStackCardRowAux)
    }
    
    func settingShadowCard(_ isCardEnabled: Bool) {
        if isCardEnabled {
            self.viewShadowCard.isHidden = true
            return
        }
        self.viewShadowCard.isHidden = false
    }
    
    private func formattedNumber(_ text: String) -> String {
        let mask = "#### #### #### ####"
        var result = ""
        var index = text.startIndex
        for ch in mask where index < text.endIndex {
            if ch == "#" {
                result.append(text[index])
                index = text.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(labelCardNickname)
        
        contentView.addSubview(viewShadowCard)
        viewShadowCard.addSubview(viewBall)
        viewBall.addSubview(imageViewLockCard)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewShadowCard.topAnchor.constraint(equalTo: self.topAnchor),
            viewShadowCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            viewShadowCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viewShadowCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewBall.widthAnchor.constraint(equalToConstant: 50),
            viewBall.heightAnchor.constraint(equalToConstant: 50),
            viewBall.centerXAnchor.constraint(equalTo: viewShadowCard.centerXAnchor),
            viewBall.centerYAnchor.constraint(equalTo: viewShadowCard.centerYAnchor),
            
            imageViewLockCard.widthAnchor.constraint(equalToConstant: 18),
            imageViewLockCard.heightAnchor.constraint(equalToConstant: 20),
            imageViewLockCard.centerXAnchor.constraint(equalTo: viewBall.centerXAnchor),
            imageViewLockCard.centerYAnchor.constraint(equalTo: viewBall.centerYAnchor),
        ])
    }
}
