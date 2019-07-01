//
//  ViewController.swift
//  Word Scramble
//
//  Created by Felipe on 6/29/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startNewGame))
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsUrl){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func startNewGame(){
        startGame()
    }
    @objc func promptForAnswer(){
        
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else{
                return
            }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func isPossible(word:String) -> Bool{
        guard var tempWord = title?.lowercased() else{
            return false
        }
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    
    func isOriginal(word:String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word:String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        guard let tempWord = title?.lowercased() else{
            return false
        }
        let rangeWord = tempWord.prefix(3)
        if word.utf16.count < 3 || word.contains(rangeWord) {
            return false
        }
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        var errorTitle =  String()
        var errorMsg = String()
        
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else{
                    errorTitle = "Word not recognised"
                    errorMsg = "You can't just make them up, you know!"
                }
            }else{
                errorTitle = "Word used already"
                errorMsg = "Be more original!"
            }
        }else{
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMsg = "You can't spell that word from \(title)"
        }
        showErrorMessage(errorMsg: errorMsg, errorTitle)

    }
    func showErrorMessage(errorMsg errorMessage:String,_ title:String){
        let ac = UIAlertController(title: title, message:
            errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    

}

