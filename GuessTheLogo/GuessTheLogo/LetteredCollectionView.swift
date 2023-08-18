//
//  LetteredCollectionView.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 19/08/23.
//

import UIKit

final class LetteredCollectionView: UIView {

    private var collectionView: UICollectionView!
    private var datasource: [Character] = ["s", "x", "v"]

    var itemClicked: ((_ index: IndexPath) -> Void)?
    required init?(coder: NSCoder) {
        fatalError("missing implementation")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JumbledCharacterCollectionCell.self, forCellWithReuseIdentifier: String(describing: JumbledCharacterCollectionCell.self))
        addSubview(collectionView)
        //TODO: make the content center alinged, not left/ right
        let leading = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let trailing = collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let top = collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let bottom = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        collectionView.reloadData()
    }

    func reloadWith(datasource: [Character]) {
        self.datasource = datasource
    }

}

extension LetteredCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index clicled - ", indexPath.item)
        itemClicked?(indexPath)
    }
}

extension LetteredCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: JumbledCharacterCollectionCell.self), for: indexPath) as? JumbledCharacterCollectionCell else {
            return UICollectionViewCell()
        }
        //TODO: Add safety check
        let char = datasource[indexPath.item]
        cell.configure(with: char)
        return cell
    }
}


class JumbledCharacterCollectionCell: UICollectionViewCell {

    // TODO: add border
    private var charLabel: UILabel!

    required init?(coder: NSCoder) {
        fatalError("missing implementation")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        charLabel = UILabel()
        charLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(charLabel)
        charLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        charLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1).isActive = true
        charLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        charLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1).isActive = true
    }

    func configure(with char: Character) {
        charLabel.text = String(char)
    }
}
