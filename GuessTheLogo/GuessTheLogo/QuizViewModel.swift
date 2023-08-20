//
//  QuizViewModel.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 20/08/23.
//

import Foundation

final class QuizViewModel {
    var levelInfo: LevelViewModel

    init(levelInfo: LevelViewModel) {
        self.levelInfo =  levelInfo
    }

    func validate(userInput: String) -> Bool {
        levelInfo.answer == userInput
    }
}
