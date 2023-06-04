//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 16.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    
    var theme: Theme

    private static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(of: theme)
    }

    var cards: [Card] {
        model.cards
    }

    // MARK: - Intent(s)

    func choose(_ card: Card) {
        model.choose(card)
    }

    func restart() {
        model = EmojiMemoryGame.createMemoryGame(of: theme)
    }
}
