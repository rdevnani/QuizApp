//
//  ViewController.swift
//  trueFalseApp
//
//  Created by Rohit Devnani on 10/6/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    
    
//Instance variables
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var option1: UIButton!
    @IBOutlet var option2: UIButton!
    @IBOutlet var option3: UIButton!
    @IBOutlet var option4: UIButton!
    @IBOutlet var option5: UIButton!
    @IBOutlet var option6: UIButton!
    let buttonColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1)
    var gameQuestions = Questions()
    var game = Game()
    var timer = Timer()
    var count = 15
    var showMenueScreen = true
    
   
    
//Instance methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        game.playGameSound("GameSound", fileType: "wav")
        displayQuestion()
    }
    
    

//IBActions
    
    
    @IBAction func playAgain() {
        // Show the answer buttons
        game.questionsAsked = 0
        game.correctQuestions = 0
        gameQuestions.indexOfSelectedQuestion = []
        showMenueScreen = true
        hideAnswerButtons(false)
        hideGameModeButtons(true)
        nextRound()
        game.playGameSound("GameSound", fileType: "wav")
    }
    
    
    @IBAction func menuAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "NormalMode" {
            showMenueScreen = false
            hideGameModeButtons(true)
            hideAnswerButtons(false)
            displayQuestion()
            
        } else {
            count = 15
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countUp), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
            timerLabel.isHidden = false
            showMenueScreen = false
            hideGameModeButtons(true)
            hideAnswerButtons(false)
            displayQuestion()
            
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        // Lock buttons
        enableAnswerButton(false)
        
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        
        let selectedQuestionDict = gameQuestions.currentQuestion
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if sender.titleLabel?.text == correctAnswer! {
            game.correctQuestions += 1
            questionField.text = "Correct!"
            game.playGameSound("SuccessSound", fileType: "mp3")
            loadNextRoundWithDelay(seconds: 1)
            
        } else {
            questionField.text = "Sorry, wrong answer!"
            game.playGameSound("ErrorSound", fileType: "wav")
            for view in self.view.subviews as [UIView] {
                if let stackView = view as? UIStackView {
                    for button in stackView.subviews as! [UIButton] {
                        if button.titleLabel?.text == correctAnswer {
                            DispatchQueue.main.async {
                                button.backgroundColor = UIColor(red: 18/255, green: 173/255, blue: 42/255, alpha: 1)
                            }
                        }
                    }
                }
            }
            loadNextRoundWithDelay(seconds: 1)
        }
    }
    
    
    
    
//Helper Methods
    
    
    func hideAnswerButtons(_ status: Bool) {
        
        option1.isHidden = status
        option2.isHidden = status
        option3.isHidden = status
        option4.isHidden = status
    }
    
    
    func enableAnswerButton(_ status: Bool) {
        
        option1.isEnabled = status
        option2.isEnabled = status
        option3.isEnabled = status
        option4.isEnabled = status
    }
    
    func changeButtonBackgroundColor(_ color: UIColor) {
        
        option1.backgroundColor = color
        option2.backgroundColor = color
        option3.backgroundColor = color
        option4.backgroundColor = color
    }
    
    func hideGameModeButtons(_ status: Bool) {
        option5.isHidden = status
        option6.isHidden = status
    }
    
    func nextRound() {
        
        changeButtonBackgroundColor(buttonColor)
        if game.questionsAsked >= game.questionsPerRound {
            // Game is over
            timerLabel.isHidden = true
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func countUp() {
        
        count -= 1
        if(count >= 0) {
            timerLabel.text = String(count)
        } else {
            DispatchQueue.main.async {
                self.count = 15
                // Increment the questions asked counter
                self.game.questionsAsked += 1
                self.questionField.text = "YOU RAN OUT OF TIME!"
                self.game.playGameSound("ErrorSound", fileType: "wav")
                self.loadNextRoundWithDelay(seconds: 1)
            }
        }
    }
    
    func displayScore() {
        
        // Hide the answer buttons
        hideAnswerButtons(true)
        
        // Display play again button
        playAgainButton.isHidden = false
        // Stop the timer from running
        timer.invalidate()
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
    }
    
    func displayQuestion() {
        
        if showMenueScreen == true {
            playAgainButton.isHidden = true
            timerLabel.isHidden = true
            hideAnswerButtons(true)
            questionField.text = "Select Game Mode"
            
        } else {
            // Select a new random question
            let questionDictionary = gameQuestions.selectRandomQuestion()
            // Update UI on main thread
            DispatchQueue.main.async {
                self.timerLabel.text = String(self.count)
                self.questionField.text = questionDictionary["Question"]
                self.option1.setTitle("\(questionDictionary["Option1"]!)", for: UIControlState())
                self.option2.setTitle("\(questionDictionary["Option2"]!)", for: UIControlState())
                self.option3.setTitle("\(questionDictionary["Option3"]!)", for: UIControlState())
                self.option4.setTitle("\(questionDictionary["Option4"]!)", for: UIControlState())
                self.playAgainButton.isHidden = true
                self.enableAnswerButton(true)
            }
        }
    }
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.count = 15
            self.nextRound()
        }
    }
}

