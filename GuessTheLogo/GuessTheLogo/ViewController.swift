//
//  ViewController.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 18/08/23.
//

import UIKit

/// TODO: redo this..
class ViewController: UIViewController {

    private var vStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViews()
    }

    private func setupInitialViews() {
        vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.spacing = 10
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        let centerY = vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let leading = vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        let trailing = vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        let height = vStack.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([leading, trailing, centerY, height])
        addStartButton()
        // TODO: Add conditions here for the resume button only when there exists a game to be resumed
        addResumeButton()
    }

    private func addStartButton() {
        // TODO: Implement a button style class
        let button = UIButton(type: .roundedRect, primaryAction: UIAction(handler: { _ in
            QuizManager.shared.start()
            let viewModel = QuizManager.shared.quizInfo
            let quizVc = QuizContainerVC(levels: viewModel)
            self.navigationController?.pushViewController(quizVc, animated: true)
        }))
        button.setTitle("New Game", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        vStack.addArrangedSubview(button)
    }

    private func addResumeButton() {
        let action = UIAction(handler: { action in
            //TODO: add handling
            print("button 2 clicked")
        })
        let button = UIButton(type: .roundedRect, primaryAction: action)
        button.setTitle("Resume Game", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        vStack.addArrangedSubview(button)
    }
}

