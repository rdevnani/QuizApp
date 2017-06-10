//
//  Game.swift
//  trueFalseApp
//
//  Created by Rohit Devnani on 10/6/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation
import AudioToolbox

class Game {
    
    let questionsPerRound: Int = 10
    var lightningMode: Bool = false
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    
    
    
    func playGameSound(_ fileName: String, fileType: String) {
        let pathToSoundFile = Bundle.main.path(forResource: fileName, ofType: fileType)
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
}
