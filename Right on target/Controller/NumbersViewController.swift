//
//  ViewController.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 29/09/2022.
//

import UIKit

class NumbersViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var labelNumber: UILabel!
    @IBOutlet var labelScores: UILabel!
    @IBOutlet var labelRound: UILabel!
    @IBOutlet var labelLastNumber: UILabel!
    
    var game: GameProtocol!
    var roud: RoundProtocol!
    var generator:GeneratorProtocol!
    
    var lastValue:Int = 25
    
    
    @IBAction func checkButtonClick(){
        //roud.calcualteScore(value: Int(slider.value.rounded()) as! String)
        roud.calculateScore(value: Int(slider.value.rounded()).description)
        if game.isGameEnded {
            showAlert(scores: game.score)
        } else {
            game.startNewRound()
        }
        
        updateLabels()
    }
    
    @IBAction func clickBack(){
        self.dismiss(animated: true)
    }
    
    func showAlert(scores: Int){
        let alert = UIAlertController(title: "Game is over", message: "Your scores \(game.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: {_ in
            self.game.restartGame()
            self.updateLabels()
        }))
        present(alert, animated: true, completion: nil )
    }
    
    func updateLabels(){
        labelNumber.text = String(roud.currentValue)
        labelRound.text = "Round: \(game.curentRound)"
        labelScores.text = "Score: \(game.score)"
        labelLastNumber.text = "Number on slider: \(Int(slider.value.rounded()))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generator = NuberGenerator(minSecretValue: 1, maxSecretValue: 50)
        roud = SliderRoud(score:0, curentValue: String(generator.getRandomValue()))
        game = Game(round: roud, secretValueGenerator: generator, rounds: 5)
        updateLabels()
        print("viewDidLoad")
    }
}

