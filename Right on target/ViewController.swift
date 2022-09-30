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
    
    var number: Int = 0
    var round: Int = 0
    var scores: Int = 0
    var lastNumber: Int = 0
    
    lazy var secondViewController = getSecondViewController()
    
    func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
    }
    
    @IBAction func checkButtonClick(){
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
            alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: {_ in self.resetScores()}))
            present(alert, animated: true, completion: nil )
        } else {
            round += 1
        }
        number = getRandomNumber()
        labelNumber.text = String(number)
        labelRound.text = "Round: \(round)"
        labelScores.text = "Score: \(scores)"
        labelLastNumber.text = "Number on slider: \(numOnSlider)"
    }
    
    func resetScores(){
        number = getRandomNumber()
        labelNumber.text = String(number)
        
        round = 1
        labelRound.text = "Round: \(round)"
        
        scores = 0
        labelScores.text = "Score: \(scores)"
        
        labelLastNumber.text = "Number on slider: 25"
    }
    
    func getRandomNumber() -> Int {
        return Int.random(in: 1...50)
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetScores()
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

