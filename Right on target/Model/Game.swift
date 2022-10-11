//
//  Game.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 01/10/2022.
//

import Foundation

// MARK: Rounds
protocol RoundProtocol {
    var score: Int { get set}
    var currentValue: String { get set }
    func calculateScore(value: String)
}

class SliderRoud: RoundProtocol {
    var secretValueGenerator: GeneratorProtocol!
    var score: Int
    var currentValue: String
    
    init?(score:Int, curentValue: String){
        self.score = score
        self.currentValue = curentValue
    }
    
    func calculateScore(value: String) {
        if Int(value)! > Int(currentValue)! {
            score += 50 - Int(value)! + Int(currentValue)!
        } else if Int(value)! < Int(currentValue)! {
            score += 50 - Int(currentValue)! + Int(value)!
        } else {
            score += 50
        }
    }
}

class ColorsRound: RoundProtocol {
    var secretValueGenerator: GeneratorProtocol!
    
    var score: Int
    var currentValue: String
    
    init?(score:Int, curentValue: String){
        self.score = score
        self.currentValue = curentValue
    }
    
    func calculateScore(value: String) {
        if value == currentValue {
            score += 1
        }
    }
}

// MARK: Generatos
protocol GeneratorProtocol{
    func getRandomValue() -> String
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
    typealias T = Int
    func getRandomValue() -> String {
        (minSecretValue...maxSecretValue).randomElement()!.description
    }
}

class ColorsGenerator: GeneratorProtocol {
    typealias T = String
    func getRandomValue() -> String {
        var hexCode = "#"
        for _ in (0...5) {
            hexCode += String((0...15).randomElement()!, radix: 16)
        }
        return hexCode.uppercased()
    }
}

// MARK: Games
protocol GameProtocol {
    var score: Int { get set}
    var isGameEnded: Bool { get }
    var curentRound: Int { get }
    
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
    var secretValueGenerator: GeneratorProtocol
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
