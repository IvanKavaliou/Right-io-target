//
//  Game.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 01/10/2022.
//

import Foundation

protocol GameProtocol {
    var score: Int { get }
    var currentValue: Int { get }
    var lastNumber: Int { get }
    var isGameEnded: Bool { get }
    var curentRound: Int { get }
    
    
    func restartGame()
    func startNewRound()
    func calculateScore(with value: Int)
}


class Game: GameProtocol {
    var score: Int = 0
    var currentValue: Int = 0
    var lastNumber: Int = 0
    
    var minSecretValue: Int
    var maxSecretValue: Int
    
    var curentRound: Int = 1
    var lastRound: Int
    
    var isGameEnded: Bool {
        if curentRound == lastRound {
            return true
        }
        return false
    }
    
    init?(minSecretValue: Int, maxSecretValue: Int, rounds: Int){
        if minSecretValue >= maxSecretValue {
            return nil
        }
        self.minSecretValue = minSecretValue
        self.maxSecretValue = maxSecretValue
        self.lastRound = rounds
        currentValue = getNewSecretValue()
    }
    
    func restartGame() {
        curentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentValue = getNewSecretValue()
        curentRound += 1
    }
    
    func calculateScore(with value: Int) {
        if value > currentValue {
            score += 50 - value + currentValue
        } else if value < currentValue {
            score += 50 - currentValue + value
        } else {
            score += 50
        }
    }
    
    func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
}
