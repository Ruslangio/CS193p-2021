//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 16.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let themes = [
        Theme(name: "Vehicles", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], numberOfPairOfCards: 8, color: "red"),
        Theme(name: "Animals", emojis: ["🦜", "🐄", "🦈", "🦔", "🐒", "🦑", "🐊", "🐅", "🦍"], numberOfPairOfCards: 5, color: "green"),
        Theme(name: "Food", emojis: ["🥩", "🍔", "🥥", "🌮", "🍕", "🍰", "🍩", "🍤", "🧀", "🥑", "🍌"], numberOfPairOfCards: 4, color: "pink"),
        Theme(name: "Flags", emojis: ["🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇦🇿", "🇬🇷", "🇨🇺", "🇰🇵", "🇵🇰", "🇯🇵"], numberOfPairOfCards: 5, color: "blue"),
        Theme(name: "Tech", emojis: ["📱", "💻", "🖥", "🕹", "🎙", "📸", "💾"], numberOfPairOfCards: 6, color: "gray"),
        Theme(name: "Simbols", emojis: ["🕉", "☣️", "🀄️", "👁‍🗨", "🎦", "♠️", "💮", "💝", "♦️"], numberOfPairOfCards: 7, color: "purple")
    ]
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    @Published private var model: MemoryGame<String>
    
    var theme: Theme
    
    var themeColor: Color {
        switch theme.color {
        case "red": return .red
        case "green": return .green
        case "pink": return .pink
        case "blue": return.blue
        case "gray": return .gray
        default: return .purple
        }
    }
    
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restart() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
