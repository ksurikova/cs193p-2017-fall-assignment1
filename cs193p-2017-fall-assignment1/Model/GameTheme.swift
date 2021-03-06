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
        Theme(emojis: "π­π±ππ¦πππΈπ₯πͺ²π·π¦", backgroundColor: .white, shirtColor: .orange),
        Theme(emojis: "πππ’π€π€‘π©π€’π€π₯³π£π¦Ύ", backgroundColor: .yellow, shirtColor: .cyan),
        Theme(emojis: "πππ₯ππ¨π·π­πΆπ«", backgroundColor: .systemGray4, shirtColor: .systemGreen),
        Theme(emojis: "β½οΈπΌπ₯ππ§π»ββοΈππ΄π»ββοΈππ₯", backgroundColor: .systemGray5, shirtColor: .systemTeal),
        Theme(emojis: "β©πβοΈππ€π‘β²οΈπβοΈπ", backgroundColor: .systemRed, shirtColor: .white),
        Theme(emojis: "π°π°ππ‘ππβοΈπ§―π§°", backgroundColor: .systemTeal, shirtColor: .black),
        Theme(emojis: "β£οΈββοΈβοΈβοΈβ¨οΈββοΈβΎ", backgroundColor: .systemGray6, shirtColor: .systemBlue),
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
