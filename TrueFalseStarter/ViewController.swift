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
    
    //Colors
    let buttonColorBlue = UIColor(colorLiteralRed: 16.0/255.0, green: 171.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    let correctAnswerColor = UIColor(colorLiteralRed: 93.0/255.0, green: 190.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    let incorrectAnswerColor = UIColor(colorLiteralRed: 221.0/255.0, green: 78.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 1
    var correctAnswerSound: SystemSoundID = 2
    var quiz = Quiz(questionsPerRound: 10, correctQuestions: 0, questionsAsked: 0)
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        playAgainButton.isHidden = true
    }

    
    
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        let question = quiz.questions[indexOfSelectedQuestion]
        if question.hasBeenAsked == false {
            questionField.text = question.text
            buttonOne.setTitle(question.answer1, for: .normal)
            buttonTwo.setTitle(question.answer2, for: .normal)
            buttonThree.setTitle(question.answer3, for: .normal)
            buttonFour.setTitle(question.answer4, for: .normal)
            quiz.questions[indexOfSelectedQuestion].hasBeenAsked = true
            if question.answer4 == nil {
                buttonFour.isHidden = true
                
            } else {
                buttonFour.isHidden = false
            }
        } else {
            print ("The randomly chosen question has already been asked. Prepare to receive a new random question")
            nextRound()
        }
        nextQuestionButton.isEnabled = false
        nextQuestionButton.alpha = 0.5
    }
    
    
    
    func displayScore() {
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true
        buttonFour.isHidden = true
        playAgainButton.isHidden = false
        if quiz.correctQuestions < quiz.questionsPerRound {
            questionField.text = "You correctly answered \(quiz.correctQuestions) out of \(quiz.questionsPerRound), but there is still room for improvement!"
        } else if quiz.correctQuestions == quiz.questionsPerRound {
            questionField.text = "Wow! You answered all the questions correctly! You must be a programmer!"
        }
    }
    
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quiz.questionsAsked += 1
        let currentQuestion = quiz.questions[indexOfSelectedQuestion]
        let correctAnswer = currentQuestion.correctAnswer
        if sender.title(for: .normal)! == correctAnswer {
            quiz.correctQuestions += 1
            questionField.text = "Great job, you got that one right!"
            sender.backgroundColor = correctAnswerColor
            loadCorrectAnswerSound()
            playCorrectAnswerSound()
        } else {
            questionField.text = "I'm sorry but the correct answer is: \"\(correctAnswer)\""
            sender.backgroundColor = incorrectAnswerColor
            loadWrongAnswerSound()
            playWrongAnswerSound()
        }
        nextQuestionButton.isEnabled = true
        nextQuestionButton.alpha = 1.0
    }
    
    
    @IBAction func nextRound() {
        buttonOne.backgroundColor = buttonColorBlue
        buttonTwo.backgroundColor = buttonColorBlue
        buttonThree.backgroundColor = buttonColorBlue
        buttonFour.backgroundColor = buttonColorBlue
        if quiz.questionsAsked == quiz.questionsPerRound {
            // Game is over
            displayScore()
            nextQuestionButton.isHidden = true
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    @IBAction func playAgain() {
        // Set all the questions to be Askable again
        quiz.resetQuestions()
        // Show the answer buttons
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
        buttonFour.isHidden = false
        nextQuestionButton.isHidden = false
        playAgainButton.isHidden = true
        quiz.questionsAsked = 0
        quiz.correctQuestions = 0
        displayQuestion()
    }
    

    
    // MARK: Helper Methods
   
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
    }
    
    func loadCorrectAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectAnswer", ofType: "mp3")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctAnswerSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}


