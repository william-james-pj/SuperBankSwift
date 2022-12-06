//
//  DrawerTableViewCell.swift
//  Home
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import UIKit

enum DrawerTableViewCellType {
    case profile
    case logoff
}

class DrawerTableViewCell: UITableViewCell {
    // MARK: - Constrants
    static let resuseIdentifier: String = "DrawerCellTableViewCell"
    
    // MARK: - Variables
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(named: "Text")
        return image
    }()
    
    private let labelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageViewArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(named: "Disabled")
        return image
    }()
    
    private let viewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
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
    
    // MARK: - Methods
    func settingCell(_ type: DrawerTableViewCellType) {
        switch type {
        case .profile:
            self.imageViewCell.image = UIImage(named: "UserLight")
            self.labelText.text = "Editar dados do Perfil"
        case .logoff:
            self.imageViewCell.image = UIImage(named: "ArrowTurnDownLeft")
            self.labelText.text = "Sair do aplicativo"
        }
    }
    
    private func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewCell)
        stackBase.addArrangedSubview(labelText)
        
        self.addSubview(imageViewArrow)
        self.addSubview(viewSeparator)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewImageContainer.widthAnchor.constraint(equalToConstant: 20),
            imageViewCell.widthAnchor.constraint(equalToConstant: 20),
            imageViewCell.heightAnchor.constraint(equalToConstant: 23),
            imageViewCell.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageViewCell.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor),
            
            imageViewArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageViewArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            viewSeparator.heightAnchor.constraint(equalToConstant: 3),
            viewSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
