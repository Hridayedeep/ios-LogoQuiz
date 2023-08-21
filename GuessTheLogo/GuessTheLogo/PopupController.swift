//
//  PopupController.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 21/08/23.
//

import UIKit

struct PopupViewModel {
    var title: String
    var body: String
    var cta: String
    var popupBgColor: UIColor

    init(title: String, body: String, cta: String, popupBgColor: UIColor = .white ) {
        self.title = title
        self.body = body
        self.cta = cta
        self.popupBgColor = popupBgColor
    }
}

final class PopupController: UIViewController {

    private var containerView: UIView!
    private var vStack: UIStackView!
    private var titleLable: UILabel!
    private var bodyLable: UILabel!
    private var cta: UIButton!
    private let viewModel: PopupViewModel

    var dismissHandler: (() -> Void)?

    init(with viewModel: PopupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupPopup()
        configureData()
    }

    func setupPopup() {
        containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        let width = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        let height = containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        let centerX = containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerY = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([height, width, centerX, centerY])
        addVStack()
    }

    private func addVStack() {
        vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(vStack)
        let top = vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10)
        let bottom = vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        let leading = vStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10)
        let trailing = vStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
        addTitle()
        addBody()
        addCta()
    }

    private func addTitle() {

    }

    private func addBody() {

    }

    private func addCta() {
        cta = UIButton(primaryAction: buttonAction)
        cta.setTitle(viewModel.cta, for: .normal)
        cta.backgroundColor = .gray
        cta.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(cta)
        cta.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cta.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private var buttonAction: UIAction {
        UIAction { _ in
            self.dismiss(animated: true, completion: self.dismissHandler)
        }
    }

    private func buttonClicked() {

    }

    private func configureData() {

    }
}
