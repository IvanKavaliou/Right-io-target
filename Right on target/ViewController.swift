//
//  ViewController.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 29/09/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    var number: Int = 0
    var round: Int = 0
    var scores: Int = 0
    
    
    @IBAction func checkButtonClick(){
        if round == 0 {
            number = getRandomNumber()
            label.text = String(number)
            round = 1
        } else {
            let numOnSlider = Int(slider.value.rounded())
            
            if numOnSlider > number {
                scores += 50 - numOnSlider + number
            } else if numOnSlider < number {
                scores += 50 - number + numOnSlider
            } else {
                scores += 50
            }
            
            if round == 5 {
                let alert = UIAlertController(title: "Game is over", message: "Your scores \(scores)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Play again", style: .default))
                present(alert, animated: true, completion: nil )
                resetScores()
            } else {
                round += 1
            }
            
            number = getRandomNumber()
            label.text = String(number)
        }
        
    }
    
    func resetScores(){
        round = 1
        scores = 0
    }
    
    func getRandomNumber() -> Int {
        return Int.random(in: 1...50)
    }

}

