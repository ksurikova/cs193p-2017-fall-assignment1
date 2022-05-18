//
//  GameTheme.swift
//  cs193p-2017-fall-assigment1
//
//  Created by Ksenia Surikova on 26.05.2021.
//

import Foundation
import UIKit

struct Theme {
    private(set) var emojis: String
    private(set) var backgroundColor: UIColor
    private(set) var shirtColor: UIColor
}

struct GameTheme {
    private var themeArray = [
        Theme(emojis: "🐭🐱🙈🦋🐝🐌🐸🐥🪲🐷🦊", backgroundColor: .white, shirtColor: .orange),
        Theme(emojis: "😍😁😢🤕🤡💩🤢🤗🥳👣🦾", backgroundColor: .yellow, shirtColor: .cyan),
        Theme(emojis: "🍏🍕🥐🍓🍨🍷🍭🌶🫐", backgroundColor: .systemGray4, shirtColor: .systemGreen),
        Theme(emojis: "⚽️🛼🥊🏇🧘🏻‍♂️🏆🚴🏻‍♀️🏓🥋", backgroundColor: .systemGray5, shirtColor: .systemTeal),
        Theme(emojis: "⛩🕌⚓️🏝🛤🎡⛲️🏔✈️🚗", backgroundColor: .systemRed, shirtColor: .white),
        Theme(emojis: "💰🕰🎞💡💎💊⚔️🧯🧰", backgroundColor: .systemTeal, shirtColor: .black),
        Theme(emojis: "♣︎☆☃︎☂︎✂︎♨︎⚃☀︎☾", backgroundColor: .systemGray6, shirtColor: .systemBlue),
    ]
    
    private(set) var backgroundColor: UIColor = .systemBackground
    private(set) var shirtColor: UIColor = .systemIndigo
    private var currentEmojiChoices = ""
    private var emojiDictionary = [Card:String]()

    
    public mutating func emojiIndentifier(for card: Card)-> String{
        if emojiDictionary[card] == nil, currentEmojiChoices.count > 0 {
            let randomStringIndex = currentEmojiChoices.index(currentEmojiChoices.startIndex,  offsetBy: currentEmojiChoices.count.arc4randomExtension)
            // get random emoji and remove from collection to avoid matched emoji
            emojiDictionary[card] = String(currentEmojiChoices.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    public mutating func setNewRandomTheme() {
        let randomIndex = themeArray.index(
            themeArray.startIndex,
            offsetBy : themeArray.count.arc4randomExtension
        )
        shirtColor = themeArray[randomIndex].shirtColor
        backgroundColor = themeArray[randomIndex].backgroundColor
        currentEmojiChoices = themeArray[randomIndex].emojis
    }
    
    init(){
        setNewRandomTheme()
    }
}
