//
//  CardDeliveryTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 19/12/22.
//

import UIKit
import Common

class CardDeliveryTableViewCell: UITableViewCell {
    // MARK: - Constrants
    static let resuseIdentifier: String = "CardDeliveryTableViewCell"
    
    // MARK: - Variables
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Disabled")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewProgress: DeliveryProgress = {
        let view = DeliveryProgress()
        return view
    }()
    
    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelDelivery: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDeliveryDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonReceived: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(named: "White")
        config.baseBackgroundColor = UIColor(named: "Primary")
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        config.buttonSize = .large
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 12, weight: .bold)
        config.attributedTitle = AttributedString("Recebi o cartão", attributes: container)
        
        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    // MARK: - Methods
    func settingCell(_ cardDelivery: CardDeliveryModel?) {
        guard let cardDelivery = cardDelivery else {
            return
        }
        
        self.labelDeliveryDate.text = "Entrega prevista: \(cardDelivery.deliveryDate)"
        let simulate = simulateUpdateStatus(deliveryDate: cardDelivery.deliveryDate)
        
        switch simulate {
        case .production:
            self.labelDelivery.text = "Cartão em produção"
            self.viewProgress.settingView(.production)
        case .delivery:
            self.labelDelivery.text = "Cartão a caminho"
            self.viewProgress.settingView(.delivery)
        case .delivered:
            self.labelDelivery.text = "Cartão entregue"
            self.viewProgress.settingView(.delivered)
        }
    }
    
    private func simulateUpdateStatus(deliveryDate: String) -> ECardDeliveryStatusType {
        let date = Date()
        let currentDay = date.get(.day)
        let currentMonth = date.get(.month)
        
        let deliveryDay = Int(String(deliveryDate.prefix(2)))
        let deliveryMonth = Int(String(deliveryDate.suffix(2)))
        
        guard let deliveryDay = deliveryDay, let deliveryMonth = deliveryMonth else {
            return .production
        }
        
        if currentMonth > deliveryMonth || currentMonth < deliveryMonth {
            return .delivered
        }
        
        if currentDay >= deliveryDay {
            return .delivered
        }
        
        if deliveryDay - 2 == currentDay {
            return .delivery
        }
        
        return .production
    }
    
    private func buildHierarchy() {
        contentView.addSubview(stackBase)
        stackBase.addArrangedSubview(viewLine)
        stackBase.addArrangedSubview(viewProgress)
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelDelivery)
        stackText.addArrangedSubview(labelDeliveryDate)
        stackBase.addArrangedSubview(viewButtonContainer)
        viewButtonContainer.addSubview(buttonReceived)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewLine.heightAnchor.constraint(equalToConstant: 1),
            
            buttonReceived.topAnchor.constraint(equalTo: viewButtonContainer.topAnchor),
            buttonReceived.leadingAnchor.constraint(equalTo: viewButtonContainer.leadingAnchor),
        ])
    }
}
