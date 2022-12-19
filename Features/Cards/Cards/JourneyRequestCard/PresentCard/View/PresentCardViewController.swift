//
//  PresentCardViewController.swift
//  Cards
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import UIKit

public class PresentCardViewController: UIViewController {
    // MARK: - Variables
    public weak var coordinatorDelegate: CardCoordinatorDelegate?
    
    // MARK: - Constantes
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
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
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // First View
    private let viewFirst: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackFirst: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainerFirst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewFirst: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person-chalkboard")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelPresent: UILabel = {
        let attrString = NSMutableAttributedString(string: "Conheça o\nnosso cartão")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelPresentSubText: UILabel = {
        let attrString = NSMutableAttributedString(string: "O cartão que expande\nsuas possibilidades.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Primary")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Second View
    private let viewSecond: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackSecond: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainerSecond: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewSecond: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mobile-signal-out")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelProximityPayment: UILabel = {
        let attrString = NSMutableAttributedString(string: "Mais praticidade e segurança\npara suas compras")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelProximityPaymentSubText: UILabel = {
        let attrString = NSMutableAttributedString(
            string: "Com a tecnologia de pagamento\npor aproximação, você paga com a\nsegurança de sempre e ainda mais\nagilidade. Basta aproximar o seu\ncartão na maquininha e pronto!"
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Primary")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Third View
    private let viewThird: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackThird: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewImageContainerThird: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewThird: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "toggle-on")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelMoreSecurity: UILabel = {
        let attrString = NSMutableAttributedString(string: "Mais segurança ao\nseu controle")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(named: "Text")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelMoreSecuritySubText: UILabel = {
        let attrString = NSMutableAttributedString(
            string: "Bloqueie temporariamente apenas\no cartão físico, apenas o digital ou\nambos e tenha mais controle sobre\nseu cartão."
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Primary")
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Button View
    private let viewButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonRequestCard: ButtonPrimary = {
        let button = ButtonPrimary()
        button.settingTitle("Solicitar o cartão")
        button.addTarget(self, action: #selector(RequestCardButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageViewSuperBackCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SuperBankCard")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let imageViewPayOnline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PayOnline")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    private func setupVC() {
        view.backgroundColor = UIColor(named: "Background")
        self.title = "Conheça o nosso Cartão"
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Actions
    @IBAction private func RequestCardButtonTapped(_ sender: UIButton) {
        self.coordinatorDelegate?.goToCreditLimit()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(stackBase)
        
        stackBase.addArrangedSubview(viewFirst)
        viewFirst.addSubview(stackFirst)
        stackFirst.addArrangedSubview(viewImageContainerFirst)
        viewImageContainerFirst.addSubview(imageViewFirst)
        stackFirst.addArrangedSubview(labelPresent)
        stackFirst.addArrangedSubview(labelPresentSubText)
        
        stackBase.addArrangedSubview(viewSecond)
        viewSecond.addSubview(stackSecond)
        stackSecond.addArrangedSubview(viewImageContainerSecond)
        viewImageContainerSecond.addSubview(imageViewSecond)
        stackSecond.addArrangedSubview(labelProximityPayment)
        stackSecond.addArrangedSubview(labelProximityPaymentSubText)
        
        stackBase.addArrangedSubview(viewThird)
        viewThird.addSubview(stackThird)
        stackThird.addArrangedSubview(viewImageContainerThird)
        viewImageContainerThird.addSubview(imageViewThird)
        stackThird.addArrangedSubview(labelMoreSecurity)
        stackThird.addArrangedSubview(labelMoreSecuritySubText)
        
        stackBase.addArrangedSubview(viewButton)
        viewButton.addSubview(buttonRequestCard)
        
        view.addSubview(imageViewSuperBackCard)
        view.addSubview(imageViewPayOnline)
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
            stackBase.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor),
            
            // First view
            viewFirst.heightAnchor.constraint(equalToConstant: 250),
            stackFirst.leadingAnchor.constraint(equalTo: viewFirst.leadingAnchor, constant: 16),
            stackFirst.trailingAnchor.constraint(equalTo: viewFirst.trailingAnchor, constant: -16),
            stackFirst.centerYAnchor.constraint(equalTo: viewFirst.centerYAnchor),
            
            viewImageContainerFirst.heightAnchor.constraint(equalToConstant: 31),
            imageViewFirst.leadingAnchor.constraint(equalTo: viewImageContainerFirst.leadingAnchor),
            imageViewFirst.centerYAnchor.constraint(equalTo: viewImageContainerFirst.centerYAnchor),
            imageViewFirst.widthAnchor.constraint(equalToConstant: 36),
            imageViewFirst.heightAnchor.constraint(equalToConstant: 31),
            
            // Second view
            viewSecond.heightAnchor.constraint(equalToConstant: 380),
            stackSecond.leadingAnchor.constraint(equalTo: viewSecond.leadingAnchor, constant: 16),
            stackSecond.trailingAnchor.constraint(equalTo: viewSecond.trailingAnchor, constant: -16),
            stackSecond.centerYAnchor.constraint(equalTo: viewSecond.centerYAnchor),
            
            viewImageContainerSecond.heightAnchor.constraint(equalToConstant: 36),
            imageViewSecond.leadingAnchor.constraint(equalTo: viewImageContainerSecond.leadingAnchor),
            imageViewSecond.centerYAnchor.constraint(equalTo: viewImageContainerSecond.centerYAnchor),
            imageViewSecond.widthAnchor.constraint(equalToConstant: 36),
            imageViewSecond.heightAnchor.constraint(equalToConstant: 36),
            
            // Third view
            viewThird.heightAnchor.constraint(equalToConstant: 350),
            stackThird.leadingAnchor.constraint(equalTo: viewThird.leadingAnchor, constant: 16),
            stackThird.trailingAnchor.constraint(equalTo: viewThird.trailingAnchor, constant: -16),
            stackThird.centerYAnchor.constraint(equalTo: viewThird.centerYAnchor),
            
            viewImageContainerThird.heightAnchor.constraint(equalToConstant: 20),
            imageViewThird.leadingAnchor.constraint(equalTo: viewImageContainerThird.leadingAnchor),
            imageViewThird.centerYAnchor.constraint(equalTo: viewImageContainerThird.centerYAnchor),
            imageViewThird.widthAnchor.constraint(equalToConstant: 36),
            imageViewThird.heightAnchor.constraint(equalToConstant: 20),
            
            // Button View
            viewButton.heightAnchor.constraint(equalToConstant: 80),
            buttonRequestCard.leadingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: 16),
            buttonRequestCard.trailingAnchor.constraint(equalTo: viewButton.trailingAnchor, constant: -16),
            buttonRequestCard.centerYAnchor.constraint(equalTo: viewButton.centerYAnchor),
            
            // images
            imageViewSuperBackCard.widthAnchor.constraint(equalToConstant: 120),
            imageViewSuperBackCard.heightAnchor.constraint(equalToConstant: 72),
            imageViewSuperBackCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageViewSuperBackCard.centerYAnchor.constraint(equalTo: stackFirst.bottomAnchor),
            
            imageViewPayOnline.widthAnchor.constraint(equalToConstant: 150),
            imageViewPayOnline.heightAnchor.constraint(equalToConstant: 210),
            imageViewPayOnline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageViewPayOnline.bottomAnchor.constraint(equalTo: stackThird.topAnchor, constant: 70),
        ])
    }
}
