//
//  QuizContainerVC.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 18/08/23.
//

import UIKit

struct QuizViewModel {
    let image: URL
    var jumbled: [String]
}

final class QuizContainerVC: UIViewController {

    private var containerView: UIView!
    private var levelInfoLabel: UILabel!
    private var iconContainerView: UIView!
    private var iconLoader: UIActivityIndicatorView!
    private var iconView: UIImageView!
    private var inputCollectionView: LetteredCollectionView!
    private var jumbledCollectionView: LetteredCollectionView!

    /// This gets updated with every level
    var viewModel: QuizViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupNavigationBar()
        setupUIElements()
        guard let imageUrl = viewModel?.image else {
            assertionFailure("missing image")
            return
        }
        iconView.downloaded(from: imageUrl)
    }
    private func setupUIElements() {
        containerView = UIView()
        containerView.backgroundColor = .black
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

        // icon
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
        let leading = inputCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30)
        let trailing = inputCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30)
        let top = inputCollectionView.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 50)
        let height = inputCollectionView.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([leading, trailing, top, height])
    }

    private func setupJumbledCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        jumbledCollectionView = LetteredCollectionView()//UICollectionView(frame: .zero, collectionViewLayout: layout)
        jumbledCollectionView.translatesAutoresizingMaskIntoConstraints = false
        jumbledCollectionView.backgroundColor = .yellow
        jumbledCollectionView.reloadWith(datasource: [ "q", " ", "q", "a", "s", "d", "f", "g", "h", "j",])
        jumbledCollectionView.itemClicked = { indexPath in
            print("this index was clicked - ", indexPath)
        }
        containerView.addSubview(jumbledCollectionView)
        //TODO: make the content center alinged, not left/ right
        let leading = jumbledCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = jumbledCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = jumbledCollectionView.topAnchor.constraint(equalTo: inputCollectionView.bottomAnchor, constant: 50)
        let height = jumbledCollectionView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([leading, trailing, top, height])
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

    private func resetView() {

    }

}


