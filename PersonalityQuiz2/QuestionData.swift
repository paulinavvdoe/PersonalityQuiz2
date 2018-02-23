//
//  QuestionData.swift
//  PersonalityQuiz2
//
//  Created by Paulina Van der Doe on 23/02/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}
// Defines what data is in the structure Question.

enum ResponseType {
    case single, multiple, ranged
}
// Three different kinds of repsonses.

struct Answer {
    var text: String
    var type: CheeseType
}
// Defines what data there is in a structue Answer.

enum CheeseType: String {
    case goat, gorgonzola, brie, gouda
// Four different kinds of cheese types.
    
    var definition: String {
        switch self {
        case .goat:
            return "You are the odd one out in a group. Changes are you do not have many firends but the ones you do have love your weirdness. You always stay true to yourself. "
        case .gorgonzola:
            return "You have a strong personality and you are not afraid to say what you think. People either love you or hate you."
        case .brie:
            return "You are a big softie. People like you because you are a sweet en genuine person. Sometimes you are a little too soft and people will make use of that. Watch out for those kind of people!"
        case .gouda:
            return "You are what you are. Nothing more and nothing less. You are a person others can build on. Others will trust you because you always do what you say."
        }
    }
    // Switches between cheesetypes and describes personality matching the cheese type.
}


