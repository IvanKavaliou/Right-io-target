//
//  MainViewController.swift
//  Right on target
//
//  Created by  Ivan Kavaliou on 01/10/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var numbersView: UIViewController!
    var colorsView: UIViewController!
    
    @IBAction func clickNumbers(){
        self.present(numbersView, animated: true, completion: nil)
    }
    
    @IBAction func clisckColors(){
        self.present(colorsView, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        numbersView = mainStoryBoard.instantiateViewController(withIdentifier: "NumbersViewController")
        colorsView = mainStoryBoard.instantiateViewController(withIdentifier: "ColorsViewController")
    }

}
