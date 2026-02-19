//
//  Trivial.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

enum TrivialCategory: String, CaseIterable {
    case geography = "Geografía"
    case artAndLiterature = "Arte y Literatura"
    case history = "Historia"
    case entertainment = "Entretenimiento"
    case scienceAndNature = "Ciencias y Naturaleza"
    case sportsAndHobbies = "Deportes y Pasatiempos"
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
