//
//  Trivial.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

import UIKit

enum TrivialCategory: String, CaseIterable {
    case geography = "Geografía"
    case artAndLiterature = "Arte y Literatura"
    case history = "Historia"
    case entertainment = "Entretenimiento"
    case scienceAndNature = "Ciencias y Naturaleza"
    case sportsAndHobbies = "Deportes y Pasatiempos"
    
    func getColor() -> UIColor {
        switch self {
        case .geography:
            return .systemBlue
        case .artAndLiterature:
            return .systemRed
        case .history:
            return .systemYellow
        case .entertainment:
            return .systemPink
        case .scienceAndNature:
            return .systemGreen
        case .sportsAndHobbies:
            return .systemPurple
        }
    }
}

struct TrivialQuestion {
    let question: String
    let answers: [TrivialAnswer]
}

struct TrivialAnswer {
    let text: String
    let isCorrect: Bool
}

typealias TrivialQuestions = [TrivialCategory: [TrivialQuestion]]
