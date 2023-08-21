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
    
    override func viewDidLoad() {
        <#code#>
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
