//
//  SetGameViewModel.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var model = SetGame()
    
    var cards: [Card] {
        model.cards
    }
    
    var deck: [Card] {
        model.deck
    }
    
    var discardPile: [Card] {
        model.discardPile
    }
    
    var isDeckEmpty: Bool {
        model.deck.isEmpty
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeCards() {
        model.dealThreeCards()
    }
    
    func restart() {
        model = SetGame()
    }
}
