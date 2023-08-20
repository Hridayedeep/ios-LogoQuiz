//
//  QuizContainerVC.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 18/08/23.
//

import UIKit

final class QuizContainerVC: UIViewController {

    private var containerView: UIView!
    private var levelInfoLabel: UILabel!
    private var iconContainerView: UIView!
    private var iconLoader: UIActivityIndicatorView!
    private var iconView: UIImageView!
    private var inputCollectionView: LetteredCollectionView!
    private var jumbledCollectionView: LetteredCollectionView!
    private var deleteButton: UIButton!

    /// This gets updated with every level
    private var viewModel: QuizViewModel
    var userInput: String = ""
    private var availableOptions: [String]

    convenience init() {
        self.init()
    }

    // TODO: remove injected value from init?
    init(levels: [Logo] = []) {
        viewModel = QuizViewModel(levelInfo: QuizManager.shared.getNextLevelInfo())
        availableOptions = viewModel.levelInfo.jumbled
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupNavigationBar()
        setupUIElements()
        iconView.downloaded(from: viewModel.levelInfo.image)
    }

    private func setupUIElements() {
        containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        let top = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        let bottom = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        let leading = containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let trailing = containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
        setupIcon()
        setupSideOptions()
        setupInputCollectionView()
        setupJumbledCollectionView()
        resetCollectionsView()
    }

    private func setupIcon() {
        // icon container
        iconContainerView = UIView()
        iconContainerView.backgroundColor = .white
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconContainerView)
        let top = iconContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50)
        let leading = iconContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60)
        let trailing = iconContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60)
        let height = iconContainerView.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([top, height, leading, trailing])
        //TODO: rounded corners
//        iconContainerView.clipsToBounds = true
//        iconContainerView.layer.cornerRadius = iconContainerView.frame.height / 2

        iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(iconView)
        let iconHeight = iconView.heightAnchor.constraint(equalTo: iconContainerView.heightAnchor)
        let iconWidth = iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor)
        let iconX = iconView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor)
        let iconY = iconView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor)
        NSLayoutConstraint.activate([iconHeight, iconWidth, iconX, iconY])
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        iconLoader = UIActivityIndicatorView(style: .large)
        iconLoader.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(iconLoader)
        let centerX = iconLoader.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor)
        let centerY = iconLoader.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
//        iconLoader.startAnimating()
    }

    private func setupInputCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        inputCollectionView = LetteredCollectionView()
        inputCollectionView.translatesAutoresizingMaskIntoConstraints = false
        inputCollectionView.backgroundColor = .red
        containerView.addSubview(inputCollectionView)
        //TODO: make the content center alinged, not left/ right
        let leading = inputCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40)
        let trailing = inputCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        let top = inputCollectionView.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 50)
        let height = inputCollectionView.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([leading, trailing, top, height])
        setupDeleteButton()
    }

    private func setupJumbledCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        jumbledCollectionView = LetteredCollectionView()
        jumbledCollectionView.translatesAutoresizingMaskIntoConstraints = false
        jumbledCollectionView.backgroundColor = .yellow
        jumbledCollectionView.itemClicked = { [weak self] indexPath in
            self?.optionClicked(at: indexPath.item)
        }
        containerView.addSubview(jumbledCollectionView)
        //TODO: make the content center alinged, not left/ right
        let leading = jumbledCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = jumbledCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = jumbledCollectionView.topAnchor.constraint(equalTo: inputCollectionView.bottomAnchor, constant: 50)
        let height = jumbledCollectionView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([leading, trailing, top, height])
    }

    private func setupDeleteButton() {
        deleteButton = UIButton(primaryAction: UIAction(handler: { _ in self.deleteClicked()}))
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tintColor = .black
        deleteButton.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        containerView.addSubview(deleteButton)
        let leading = deleteButton.leadingAnchor.constraint(equalTo: inputCollectionView.trailingAnchor, constant: 10)
        let top = deleteButton.topAnchor.constraint(equalTo: inputCollectionView.topAnchor, constant: 10)
        let width = deleteButton.widthAnchor.constraint(equalToConstant: 30)
        let height = deleteButton.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([leading, top, height, width])
    }

    //TODO: insert back to the options at the same index
    private func deleteClicked() {
        print("delete", userInput)
        guard !userInput.isEmpty else { return }
        let dropping = String(userInput.removeLast())
        guard let insertIndex = availableOptions.firstIndex(where: { $0.isEmpty }) else { return }
        print("insertIndex - ", insertIndex)
        userInput = userInput.charArray.map{String($0)}.reduce("", +)
        availableOptions[insertIndex] = dropping
        print("after userInput - ", userInput)
        resetCollectionsView()
    }

    // TODO: implement side buttons
    private func setupSideOptions() {
        setupLeftOptions()
        setupRightOptions()
    }

    private func setupLeftOptions() {}
    private func setupRightOptions() {}


    private func setupNavigationBar() {
        let hintsButton = UIButton(primaryAction: UIAction(handler: { _ in
            // TODO: implement hints flow
            print("handle hints")
        }))
        hintsButton.setTitle("??", for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: hintsButton)
    }

    private func resetCollectionsView() {
        inputCollectionView.reloadWith(datasource: userInput.charArray)
        jumbledCollectionView.reloadWith(datasource: availableOptions)
    }

    private func optionClicked(at index: Int) {
        guard availableOptions[index] != "" else { return }
        userInput.append(availableOptions[index])
        availableOptions[index] = ""
        if viewModel.validate(userInput: userInput) {
            showPopup()
        }
        resetCollectionsView()
    }

    func showPopup() {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        let width = view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
        let height = view.heightAnchor.constraint(equalTo: view.widthAnchor)
        let centerX = view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerY = view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        NSLayoutConstraint.activate([height, width, centerX, centerY])
    }
}


