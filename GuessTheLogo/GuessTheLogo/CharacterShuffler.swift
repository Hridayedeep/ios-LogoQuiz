//
//  CharacterShuffler.swift
//  LogoStarterProject
//
//  Created by Hridayedeep Gupta on 04/07/23.
//

import Foundation

final class CharacterShuffler {

    let givenString: String
    let maxLength: Int

    init(givenString: String, maxLength: Int = 15) {
        self.givenString = givenString
        self.maxLength = givenString.count > 15 ? givenString.count : maxLength
    }

    func shuffle(using technique: Technique = .defaultShuffle) -> String {
        switch technique {
            case .defaultShuffle:
                return defaultShuffle
            case .second, .third, .exactSame:
                return givenString
        }
    }

    enum Technique {
        case defaultShuffle
        case second
        case third
        case exactSame
    }

    private var defaultShuffle: String {
        String(Array(givenString).shuffled())
    }
}
