//
//  LogoQuizVC.swift
//  LogoStarterProject
//
//  Created by Hridayedeep Gupta on 04/07/23.
//

import UIKit

class LogoQuizVC: UIViewController {

    @IBOutlet private var exitButton: UIButton!
    @IBOutlet private var hintButton: UIButton!
    @IBOutlet private var pauseButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var logoView: UIImageView!
    @IBOutlet weak var jumbledCollection: UICollectionView!

    var viewModel: QuizViewModel?

    @IBOutlet weak var answerInputView: UITextField!

    var userInputString: String = "" {
        didSet {
            answerInputView.text = userInputString
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        jumbledCollection.delegate = self
        jumbledCollection.dataSource = self
        jumbledCollection.register(JumbledCharacterCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        guard let imageUrl = viewModel?.image else {
            assertionFailure("missing image")
            return
        }
        logoView.downloaded(from: imageUrl)
    }
    @IBAction func nextButton(_ sender: Any) {

//        getNextLevelInfo
    }
}

extension LogoQuizVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.jumbled.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: JumbledCharacterCollectionCell.self), for: indexPath) as? JumbledCharacterCollectionCell else {
            print("cannot find cell")
            return UICollectionViewCell()
        }
        if let jumbled = viewModel?.jumbled,
           indexPath.item <= jumbled.count {
//            cell.configure(with: jumbled[indexPath.item])
        }
        return cell
    }
}

extension LogoQuizVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item clicked - ", indexPath.item)
        if let jumbled = viewModel?.jumbled,
           indexPath.item <= jumbled.count {
            userInputString.append(jumbled[indexPath.item])
        }
    }
}
