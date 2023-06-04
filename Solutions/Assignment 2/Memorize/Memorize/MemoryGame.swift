//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 16.07.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyOneFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasAlreadyBeenSeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].hasAlreadyBeenSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].hasAlreadyBeenSeen = true
                cards[potentialMatchIndex].hasAlreadyBeenSeen = true
                indexOfTheOneAndOnlyOneFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyOneFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
        var hasAlreadyBeenSeen = false
    }
}

struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairOfCards: Int
    var color: String
    
    init(name: String, emojis: [String], numberOfPairOfCards: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairOfCards = numberOfPairOfCards > emojis.count ? emojis.count : numberOfPairOfCards
        self.color = color
    }
}
