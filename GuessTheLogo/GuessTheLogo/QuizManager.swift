//
//  QuizManager.swift
//  GuessTheLogo
//
//  Created by Hridayedeep Gupta on 19/08/23.
//

import Foundation

final class QuizManager {

    static let shared = QuizManager()
    var currentLevel = 0
    var quizInfo: [Logo] = []

    private init() {}

    func start() {
        let provider = QuizProvider()
        quizInfo = provider.fetchData()
    }

    func getNextLevelInfo() -> LevelViewModel {
//        guard currentLevel <= quizInfo.count else {
//            assertionFailure("index mismatch")
//            return nil
//        }
        let levelInfo = quizInfo[currentLevel]
        let shuffler = CharacterShuffler(givenString: levelInfo.name)
        let shuffledString: [String] = shuffler.shuffle().charArray
        print("shuffledString - ", shuffledString)
        return LevelViewModel(image: levelInfo.imgUrl, jumbled: shuffledString, answer: levelInfo.name)
    }
}
