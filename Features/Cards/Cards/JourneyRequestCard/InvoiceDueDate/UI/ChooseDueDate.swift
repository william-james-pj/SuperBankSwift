//
//  ChooseDueDate.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import UIKit
import RxSwift

class ChooseDueDate: UIView {
    // MARK: - Constaints
    let didSelectDueDate = PublishSubject<String>()

    // MARK: - Variables
    private var buttonElements: [String] = []
    private var elementViews: [ViewDueDate] = []

    // MARK: - Setup
    private func setupVC() {
        self.translatesAutoresizingMaskIntoConstraints = false
        createButton()
        configStack()
    }

    // MARK: - Actions
        @IBAction func buttonTapped(sender: UIButton) {
            for (elementIndex, elementView) in elementViews.enumerated() {
                elementView.deselectView()
                if elementView.buttonSelect == sender {
                    elementView.selectView()
                    self.didSelectDueDate.onNext(buttonElements[elementIndex])
                }
            }
        }

    // MARK: - Methods
        func setButtonTitles(_ items: [String]) {
            self.buttonElements = items
            self.setupVC()
        }

        fileprivate func createButton() {
            self.elementViews = [ViewDueDate]()
            self.elementViews.removeAll()
            self.subviews.forEach({$0.removeFromSuperview()})
            for (buttonElement) in buttonElements {
                let view = ViewDueDate()
                view.setText(buttonElement)
                view.buttonSelect.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                elementViews.append(view)
            }
        }

        fileprivate func configStack() {
            let stackBase = UIStackView(arrangedSubviews: elementViews)
            stackBase.axis = .horizontal
            stackBase.spacing = 8
            stackBase.distribution = .equalSpacing
            stackBase.translatesAutoresizingMaskIntoConstraints = false

            self.addSubview(stackBase)

            NSLayoutConstraint.activate([
                stackBase.topAnchor.constraint(equalTo: self.topAnchor),
                stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
}
