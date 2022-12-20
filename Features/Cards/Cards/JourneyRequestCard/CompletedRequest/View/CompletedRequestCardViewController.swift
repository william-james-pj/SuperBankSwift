//
//  CompletedRequestCardViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 13/12/22.
//

import UIKit

public class CompletedRequestCardViewController: UIViewController {
    // MARK: - Constrants
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    
    // MARK: - Components
    private let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewDelivery: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "delivery")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelTitle: UILabel = {
        let attrString = NSMutableAttributedString(string: "Seu novo cartão já\nestá a caminho")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelPath: UILabel = {
        let attrString = NSMutableAttributedString(string: "Acompanhe o trajeto pelo\naplicativo")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.attributedText = attrString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonNext: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("Finalizar")
        button.addTarget(self, action: #selector(NextButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Actions
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.finalizeRequest()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewDelivery)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(labelPath)
        stackBase.addArrangedSubview(viewStackAux)
        
        view.addSubview(buttonNext)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewImageContainer.heightAnchor.constraint(equalToConstant: 150),
            imageViewDelivery.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageViewDelivery.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor, constant: 32),
            imageViewDelivery.widthAnchor.constraint(equalToConstant: 182),
            imageViewDelivery.heightAnchor.constraint(equalToConstant: 80),
            
            buttonNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
