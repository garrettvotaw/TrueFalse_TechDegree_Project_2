//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Garrett Votaw on 7/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


struct Question {
    let text: String
    let answer1: String
    let answer2: String
    let answer3: String?
    let answer4: String?
    let correctAnswer: String
    var hasBeenAsked: Bool
}
