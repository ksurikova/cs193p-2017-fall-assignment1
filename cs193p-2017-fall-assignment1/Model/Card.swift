//
//  Card.swift
//  cs193p-2017-fall-assigment1
//
//  Created by Ksenia Surikova on 18.05.2021.
//

import Foundation

struct Card : Hashable {
    var isFaceUp = false
    {
        didSet {
            if self.isFaceUp {
                wasAlreadyFacedUp = true
            }
        }
    }
    var isMatched = false
    var wasAlreadyFacedUp = false
    private var identifier: Int
    
    private static var identifierNumber = 0
    private static func identifierGenerator() -> Int{
        identifierNumber+=1
        return identifierNumber
    }
    init(){
        self.identifier = Card.identifierGenerator()
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card)-> Bool{
        return lhs.identifier == rhs.identifier
    }
    
}
