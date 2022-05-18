//
//  ViewController.swift
//  cs193p-2017-fall-assigment1
//
//  Created by Ksenia Surikova on 17.05.2021.
//

import UIKit

class ConcentrationGameViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var gameTheme = GameTheme()
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count+1 )/2
    }
    
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var cardsView: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
   
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlips()
        }
    }
    @IBOutlet private weak var startGameButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!{
        didSet {
            updateScore()
        }
    }
    
    //MARK: TIMER
    private var timer: Timer?
    private var winTime = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    @IBAction private func touchStartGame(_ sender: UIButton) {
       startGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func startGame(){
        game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
        gameTheme.setNewRandomTheme()
        setViewForStartGame()
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(gameTheme.emojiIndentifier(for: card), for: UIControl.State.normal)
                button.backgroundColor = gameTheme.backgroundColor
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): gameTheme.shirtColor
            }
        }
        updateFlips()
        updateScore()
        if game.gameOver {
            createTimerToShowWinLabel()
        }
    }
    
    private func updateFlips()
    {
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func updateScore()
    {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func setViewForStartGame()
    {
        cancelTimer()
        cardsView.alpha = 1.0
        backgroundView.alpha = 0.0
        self.view.backgroundColor = gameTheme.backgroundColor
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = gameTheme.shirtColor
        }
        flipCountLabel.textColor = gameTheme.shirtColor
        winLabel.textColor = gameTheme.shirtColor
        scoreLabel.textColor = gameTheme.shirtColor
        startGameButton.setTitleColor(gameTheme.shirtColor, for: .normal)
        updateFlips()
        updateScore()
    }
    
    @objc private func showWinLabel() {
        cardsView.alpha = 0.0
        backgroundView.alpha = 1.0
        cancelTimer()
    }
    
    //MARK: TIMER FUNCTIONS
    private func createTimerToShowWinLabel() {
        if timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: winTime,
                                             target: self,
                                             selector: #selector(showWinLabel),
                                             userInfo: nil,
                                             repeats: false)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
}


extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        }
        else if (self < 0){
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            // it is 0
            return self
        }
    }
}
