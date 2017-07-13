//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Garrett Votaw on 7/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


class Question {
    let text: String
    let answer1: String
    let answer2: String
    let answer3: String?
    let answer4: String?
    let correctAnswer: String
    var hasBeenAsked: Bool
    
    
    init(text: String, answer1: String, answer2: String, answer3: String?, answer4: String?, correctAnswer: String, hasBeenAsked: Bool) {
        self.text = text
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAnswer = correctAnswer
        self.hasBeenAsked = hasBeenAsked
    }
}
