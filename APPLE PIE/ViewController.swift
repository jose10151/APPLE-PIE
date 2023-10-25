//
//  ViewController.swift
//  APPLE PIE
//
//  Created by 4d on 10/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    var currentGame: Game!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program", "Antigua", "Lisette"]
    
    let incorrectMovesAllowed = 7
    
    
    var totalWins = 0 {
    didSet {
    newRound()
     }
    }
    var totalLosses = 0 {
    didSet {
    newRound()
    }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        
        // Do any additional setup after loading the view.
    }
    
    func enableLetterButtons(_ enable: Bool) {
    for button in letterButtons {
    button.isEnabled = enable
    }
    }


    
    
    func newRound() {
    if !listOfWords.isEmpty {
    let newWord = listOfWords.removeFirst()
    currentGame = Game(word: newWord, incorrectMovesRemaining:
    incorrectMovesAllowed, guessedLetters: [])
    enableLetterButtons(true)
    updateUI()
    }
    else {
    enableLetterButtons(false)
    }
    }

    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
         let letterString = sender.configuration!.title
                let letter = Character((letterString?.lowercased())!)
                currentGame.playerGuessed(letter: letter)

        updateGameState()
        
        
        updateUI()
        
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
        
        
    }
    
}



