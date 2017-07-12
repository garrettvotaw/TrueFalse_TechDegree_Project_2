//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var quiz = Quiz(questionsPerRound: 10, correctQuestions: 0, questionsAsked: 0)
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        playAgainButton.isHidden = true
    }
    
    
    
    
    
    func displayQuestion() {
//        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
//        let questionDictionary = trivia[indexOfSelectedQuestion]
//        questionField.text = questionDictionary["Question"]
//        playAgainButton.isHidden = true
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        let question = quiz.questions[indexOfSelectedQuestion]
        if question.hasBeenAsked == false {
            questionField.text = question.text
            buttonOne.setTitle(question.answer1, for: .normal)
            buttonTwo.setTitle(question.answer2, for: .normal)
            buttonThree.setTitle(question.answer3, for: .normal)
            buttonFour.setTitle(question.answer4, for: .normal)
            quiz.questions[indexOfSelectedQuestion].hasBeenAsked = true
        } else {
            print ("This question has already been asked you need to handle it and ask another question")
            nextRound()
        }
        
    }
    
    func displayScore() {
//        // Hide the answer buttons
//        trueButton.isHidden = true
//        falseButton.isHidden = true
//        
//        // Display play again button
//        playAgainButton.isHidden = false
//        
//        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true
        buttonFour.isHidden = true
        
        playAgainButton.isHidden = false
        questionField.text = "You correctly answered \(quiz.correctQuestions) out of \(quiz.questionsPerRound)"
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
//        // Increment the questions asked counter
//        questionsAsked += 1
//        
//        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
//        let correctAnswer = selectedQuestionDict["Answer"]
//        
//        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
//            correctQuestions += 1
//            questionField.text = "Correct!"
//        } else {
//            questionField.text = "Sorry, wrong answer!"
//        }
//        
//        loadNextRoundWithDelay(seconds: 2)
        
        quiz.questionsAsked += 1
        let currentQuestion = quiz.questions[indexOfSelectedQuestion]
        let correctAnswer = currentQuestion.correctAnswer
        
        if sender.title(for: .normal)! == correctAnswer {
            quiz.correctQuestions += 1
            questionField.text = "Great job, you got that one right!"
        } else {
            questionField.text = "NOPE!"
        }
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if quiz.questionsAsked == quiz.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Set all the questions to be Askable again
        for var question in quiz.questions {
            question.hasBeenAsked = false
        }
        // Show the answer buttons
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
        buttonFour.isHidden = false
        playAgainButton.isHidden = true
        quiz.questionsAsked = 0
        quiz.correctQuestions = 0
        displayQuestion()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

