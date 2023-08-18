//
//  QuizProvider.swift
//  LogoStarterProject
//
//  Created by Hridayedeep Gupta on 04/07/23.
//

import Foundation

final class QuizProvider {

    enum Source {
        case local(String)
        case server(String)
    }

    func fetchData(from source: Source = .local("logo")) -> [Logo] {
        switch source {
            case .local(let path):
                return readFromFile(path: path)
            case .server:
                assertionFailure("not implemented yet")
                return []
        }
    }

    private func readFromFile(path: String) -> [Logo] {
        do {
            guard let path = Bundle.main.path(forResource: path, ofType: "json") else {
                print("wrong path")
                return []
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder().decode([Logo].self, from: data)
        } catch {
            print("Failed to fetch contents from this file")
            return []
        }
    }

}
//
//struct QuizModel: Codable {
//
//}

struct Logo: Codable {
    let imgUrl: URL
    let name: String
}
