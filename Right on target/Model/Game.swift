//
//  Game.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 01/10/2022.
//

import Foundation

protocol RoundProtocol {
    var score: Int { get set}
    var currentValue: Int { get set }
    
    func calcualteScore(value: Int)
}

class SliderRoud: RoundProtocol {
    var score: Int
    var currentValue: Int
    
    init?(score:Int, curentValue: Int){
        self.score = score
        self.currentValue = curentValue
    }
    
    func calcualteScore(value: Int) {
        if value > currentValue {
            score += 50 - value + currentValue
        } else if value < currentValue {
            score += 50 - currentValue + value
        } else {
            score += 50
        }
    }}

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class NuberGenerator: GeneratorProtocol {
    
    var minSecretValue: Int
    var maxSecretValue: Int
    
    init?(minSecretValue: Int, maxSecretValue:Int){
        if minSecretValue >= maxSecretValue {
            return nil
        }
        self.minSecretValue = minSecretValue
        self.maxSecretValue = maxSecretValue
    }
    
    func getRandomValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
    
    
}

protocol GameProtocol {
    var score: Int { get set}
    var isGameEnded: Bool { get }
    var curentRound: Int { get }
    
    var secretValueGenerator: GeneratorProtocol! { get }
    var round: RoundProtocol! { get }
    
    func restartGame()
    func startNewRound()
}


class Game: GameProtocol {
    var score: Int {
        get {
            return round.score
        }
        set {}
    }
    var secretValueGenerator: GeneratorProtocol!
    var round: RoundProtocol!

    var lastNumber: Int = 0
    
    var curentRound: Int = 1
    var lastRound: Int
    
    var isGameEnded: Bool {
        if curentRound == lastRound {
            return true
        }
        return false
    }
    
    init?(round: RoundProtocol, secretValueGenerator:GeneratorProtocol, rounds: Int){
        self.round = round
        self.secretValueGenerator = secretValueGenerator
        self.lastRound = rounds
        self.round.currentValue = secretValueGenerator.getRandomValue()
    }
    
    func restartGame() {
        curentRound = 0
        score = 0
        round.score = 0
        startNewRound()
    }
    
    func startNewRound() {
        self.round.currentValue = secretValueGenerator.getRandomValue()
        curentRound += 1
    }
}
