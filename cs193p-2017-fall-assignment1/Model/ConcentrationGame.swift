//
//  ConcentrationGame.swift
//  cs193p-2017-fall-assigment1
//
//  Created by Ksenia Surikova on 18.05.2021.
//

import Foundation

struct ConcentrationGame
{
    private(set) var cards = [Card]()
    
    private(set) var score = 0
    private(set) var flipCount = 0
    let matchPoint = 1
    let penaltyPoint = 1
    let velocityAdditionalPoint = 1
    let timeToGetAdditionalPointsInSeconds : Double = 1
    
    private var dateTimeClick: Date?
    
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            return cards.indices.filter(){cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var gameOver: Bool {
        get {
            return cards.filter{$0.isMatched}.count == cards.count
        }
    }
    
    init(numberOfPairsOfCards : Int){
        assert(numberOfPairsOfCards > 0, "Concentration game init \(numberOfPairsOfCards) must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards+=[card, card]
        }
        cards = cards.shuffled()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : chosen index not in the cards")
        flipCount+=1
        if (!cards[index].isMatched){
            // only one card is face up and we touch another card
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index{
                // checking if 2 cards match
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                    score = score + matchPoint + getAdditionalPoints(prevoiusClickTime: dateTimeClick!)
                }
                else {
                    //print("no match, my card already face up = \(cards[index].wasAlreadyFacedUp)")
                    // check if we have penalty
                    if (cards[index].wasAlreadyFacedUp) {
                        score-=penaltyPoint
                    }
                }
                cards[index].isFaceUp = true
            }
            else
            {
                indexOfOneAndOnlyFaceUpCard = index
            }
            dateTimeClick = Date()
        }
    }
    
    
    private func getAdditionalPoints(prevoiusClickTime: Date) -> Int {
        return abs(prevoiusClickTime.timeIntervalSinceNow) < timeToGetAdditionalPointsInSeconds ? velocityAdditionalPoint : 0
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
