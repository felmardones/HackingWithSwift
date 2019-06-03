//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Felipe on 6/3/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var howManyQuestions = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        countries.append("estonia")
//        countries.append("france")
//        countries.append("germany")
//        countries.append("ireland")
//        countries.append("italy")
//        countries.append("monaco")
//        countries.append("nigeria")
//        countries.append("poland")
//        countries.append("russia")
//        countries.append("spain")
//        countries.append("uk")
//        countries.append("us")
        //More effecient
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland", "russia", "spain",
                      "uk", "us"]
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) | score: \(score)"
        if(howManyQuestions == 10){
            let totalScoreText = "Your final score is \(score)"
            let finalAlert = UIAlertController.init(title: "Results", message: totalScoreText, preferredStyle:.alert)
            finalAlert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: resetGame))
            present(finalAlert,animated: true)
            return
            
        }
        howManyQuestions += 1
    
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String = ""
       
        if( sender.tag == correctAnswer ){
            title = "Correct"
            score += 1
        }else{
            title = "Wrong, that's the flag from \(countries[sender.tag])"
            score = score > 0 ? score - 1 : 0
        }
        let alert = UIAlertController.init(title: title, message: "Your current score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alert,animated: true)
    }
    
    func resetGame(action: UIAlertAction! = nil){
        howManyQuestions = 0
        score = 0
        askQuestion()
    }
    
}

