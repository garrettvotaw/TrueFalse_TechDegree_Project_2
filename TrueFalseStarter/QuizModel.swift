//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Garrett Votaw on 7/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

class Quiz {
    let questionsPerRound: Int
    var correctQuestions: Int
    var questionsAsked: Int
    var questions: [Question] = [
    
    Question(text: "What can JSON be best represented by in Swift?", answer1: "Dictionary", answer2: "Array", answer3: "Object", answer4: "Optional", correctAnswer: "Dictionary", hasBeenAsked: false),
    
    Question(text: "Who created Swift?", answer1: "Tim Cook", answer2: "Steve Jobs", answer3: "Craig Federico", answer4: "Chris Lattner", correctAnswer: "Chris Lattner", hasBeenAsked: false),
    
    Question(text: "What unique feature does Swift offer to handle nil values?", answer1: "Arrays", answer2: "Optionals", answer3: "Closures", answer4: nil, correctAnswer: "Optionals", hasBeenAsked: false),
    
    Question(text: "What is a function called that uses control flow to solve a problem?", answer1: "Algorithm", answer2: "Closure", answer3: "Loop", answer4: nil, correctAnswer: "Algorithm", hasBeenAsked: false),
    
    Question(text: "When what Swift released?", answer1: "2000", answer2: "2015", answer3: "2014", answer4: "2013", correctAnswer: "2014", hasBeenAsked: false),
    
    Question(text: "What is the best programming language?", answer1: "Java💩", answer2: "C💩", answer3: "Swift❤️", answer4: "Python💩", correctAnswer: "Swift❤️", hasBeenAsked: false),
    
    Question(text: "Which compiler is used to make iPhone apps?", answer1: "Xcode", answer2: "Eclipse", answer3: "Sublime", answer4: nil, correctAnswer: "Xcode", hasBeenAsked: false),
    
    Question(text: "When was the first iPhone released?", answer1: "1999", answer2: "2005", answer3: "2007", answer4: nil, correctAnswer: "2007", hasBeenAsked: false),
    
    Question(text: "When was the Apple I introduced?", answer1: "1976", answer2: "1982", answer3: "1968", answer4: "1999", correctAnswer: "1976", hasBeenAsked: false),
    
    Question(text: "What is Apple's System Font", answer1: "Helvetica", answer2: "Arial", answer3: "Verdana", answer4: "San Francisco", correctAnswer: "San Francisco", hasBeenAsked: false)
    
    ]
    
    init(questionsPerRound: Int, correctQuestions: Int, questionsAsked: Int) {
        self.questionsPerRound = questionsPerRound
        self.correctQuestions = correctQuestions
        self.questionsAsked = questionsAsked
    }
    
    
    
    //This function resets the "hasBeenAsked" property on all Questions in the array. (Call this when re-setting the game)
    func resetQuestions() {
        for question in questions {
            if question.hasBeenAsked {
                question.hasBeenAsked = false
            }
        }
    }
}








