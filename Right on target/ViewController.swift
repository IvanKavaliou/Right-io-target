//
//  ViewController.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 29/09/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var labelNumber: UILabel!
    @IBOutlet var labelScores: UILabel!
    @IBOutlet var labelRound: UILabel!
    @IBOutlet var labelLastNumber: UILabel!
    
    var game: GameProtocol!
    
    @IBAction func checkButtonClick(){
        game.calculateScore(with: Int(slider.value.rounded()))
        
        if game.isGameEnded {
            showAlert(scores: game.score)
        } else {
            game.startNewRound()
        }
        
        updateLabels()
    }
    
    func showAlert(scores: Int){
        let alert = UIAlertController(title: "Game is over", message: "Your scores \(scores)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: {_ in
            self.game.restartGame()
            self.updateLabels()
        }))
        present(alert, animated: true, completion: nil )
    }
    
    func updateLabels(){
        labelNumber.text = String(game.currentValue)
        labelRound.text = "Round: \(game.curentRound)"
        labelScores.text = "Score: \(game.score)"
        labelLastNumber.text = "Number on slider: \(Int(slider.value.rounded()))"
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(minSecretValue: 1, maxSecretValue: 50, rounds: 5)
        updateLabels()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
}

