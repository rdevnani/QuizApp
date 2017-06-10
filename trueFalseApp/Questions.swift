//
//  Questions.swift
//  trueFalseApp
//
//  Created by Rohit Devnani on 10/6/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation
import GameKit

struct Questions {
    
    var indexOfSelectedQuestion: [Int] = []
    var currentQuestion = [String:String]()
    let questions: [[String:String]] = [
        
        ["Question": "At Dartmouth College in 1964 John Kemeny and Thomas Kurtz invented .... ?", "Option1": "ALGOL", "Option2": "BASIC", "Option3": "FORTRAN", "Option4": "SWIFT", "Answer": "BASIC"],
        
        ["Question": "Complete this quote “Computers are useless. They can only give you -------” (Pablo Picasso)", "Option1": "numbers", "Option2": "pictures", "Option3": "headaches", "Option4": "answers", "Answer": "answers"],
        
        ["Question": "Who invented C++", "Option1": "Larry Wall", "Option2": "Anders Hejlsberg", "Option3": "Bjarne Stroustrup", "Option4": "Alan Cooper", "Answer": "Bjarne Stroustrup"],
        
        ["Question": "Which of these is not a functional programming language?", "Option1": "F#", "Option2": "Kite", "Option3": "Fortran", "Option4": "Miranda", "Answer": "Fortran"],
        
        ["Question": "Dylan, Erlang, Haskell and ML are examples of ... ?", "Option1": "exception", "Option2": "harness", "Option3": "expression", "Option4": "assertion", "Answer": "assertion"],
        
        ["Question": "A section of code that responds to a particular interaction of the user with a gui control is called a ... ?", "Option1": "Dispatch function", "Option2": "event handler", "Option3": "control structure", "Option4": "exception handler", "Answer": "event handler"],
        
        ["Question": "RISC is ...", "Option1": "a defensive programming style", "Option2": "a web framework", "Option3": "a threading library", "Option4": "a CPU design strategy", "Answer": "a CPU design strategy"],
        
        ["Question": "I define 8 different methods, including CONNECT, PATCH, PUT and POST. I am stateless. I have a four letter name. What am I ?", "Option1": "HTTP", "Option2": "JAVA", "Option3": "C+++", "Option4": "LISP", "Answer": "HTTP"],
        
        ["Question": "Javascript is a trademake of which company ?", "Option1": "Sun Microsystems", "Option2": "Apple", "Option3": "Samsung", "Option4": "Google", "Answer": "Sun Microsystems"],
        
        ["Question": "You could use XSLT to ...", "Option1": "speed up database queries", "Option2": "encrypt passwords", "Option3": "cache html pages", "Option4": "transform XML into HTML", "Answer": "transform XML into HTML"]
        
    ]
    
    
    
    // Generate a random index number with max size equal to the number of questions
    func randomIndexNum() -> Int {
        return GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    }
    
    // Return a randomly selected question from the questions array
    mutating func selectRandomQuestion() -> [String:String] {
        var questionSelected = false
        
        while (questionSelected == false) {
            let randomQ = randomIndexNum()
            
            if (indexOfSelectedQuestion.count >= questions.count ){ break
            }
            else if indexOfSelectedQuestion.contains(randomQ) {
                // Guess another number
            } else {
                let selectedQuestion = questions[randomQ]
                indexOfSelectedQuestion.append(randomQ)
                currentQuestion = selectedQuestion
                questionSelected = true
                return selectedQuestion
            }
        }
        return ["nil": "nil"]
    }
}


