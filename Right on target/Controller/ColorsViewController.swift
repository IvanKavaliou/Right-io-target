//
//  ColorsViewController.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 01/10/2022.
//

import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var color1Button: UIButton!
    @IBOutlet var color2Button: UIButton!
    @IBOutlet var color3Button: UIButton!
    @IBOutlet var color4Button: UIButton!
    
    @IBOutlet var secretColorLabel: UILabel!
    
    
    var game: GameProtocol!
    var roud: RoundProtocol!
    var generator:GeneratorProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //color1Button.backgroundColor = hexStringToUIColor(hex: "#FF00FF")
        generator = ColorsGenerator()
        roud = ColorsRound(score: 0, curentValue: generator.getRandomValue())
        game = Game(round: roud, secretValueGenerator: generator, rounds: 5)
        updateLabels()
        setSecretValueToButtons()
    }
    
    func updateLabels(){
        roundLabel.text = "Round: \(game.curentRound)"
        scoreLabel.text = "Score: \(game.score)"
        secretColorLabel.text = roud.currentValue
    }
    
    
    @IBAction func clickColor(sender: UIButton){
        //secretColorLabel.text = sender.titleLabel?.text
        
        roud.calculateScore(value: hexStringFromColor(color: sender.backgroundColor!))
        if game.isGameEnded {
            showAlert(scores: game.score)
        } else {
            game.startNewRound()
        }
        
        updateLabels()
        setSecretValueToButtons()
    }
    
    func setSecretValueToButtons(){
        let colors = [color1Button, color2Button, color3Button, color4Button]
        
        for color in colors {
            let hexColor = generator.getRandomValue()
            color?.backgroundColor = hexStringToUIColor(hex: hexColor)
           // color?.setTitle(hexColor, for: .normal)
        }
        
        colors.randomElement()??.backgroundColor = hexStringToUIColor(hex: roud.currentValue)
    }
    
    func showAlert(scores: Int){
        let alert = UIAlertController(title: "Game is over", message: "Your scores \(game.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: {_ in
            self.game.restartGame()
            self.updateLabels()
            self.setSecretValueToButtons()
        }))
        present(alert, animated: true, completion: nil )
    }
    
    @IBAction func clickBack(){
        self.dismiss(animated: true)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }
}
