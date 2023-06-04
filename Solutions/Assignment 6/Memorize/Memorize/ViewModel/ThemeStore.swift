//
//  ThemeStore.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 09.05.2023.
//

import SwiftUI

class ThemeStore: ObservableObject {
    static let staticThemes = [
        Theme(name: "Vehicles", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], numberOfPairOfCards: 8, rgbaColor: RGBAColor(red: 1, green: 1, blue: 0, alpha: 1)),
        Theme(name: "Animals", emojis: ["🦜", "🐄", "🦈", "🦔", "🐒", "🦑", "🐊", "🐅", "🦍"], numberOfPairOfCards: 5, rgbaColor: RGBAColor(red: 0.5, green: 1, blue: 0.5, alpha: 1)),
        Theme(name: "Food", emojis: ["🥩", "🍔", "🥥", "🌮", "🍕", "🍰", "🍩", "🍤", "🧀", "🥑", "🍌"], numberOfPairOfCards: 4, rgbaColor: RGBAColor(red: 1, green: 0, blue: 0, alpha: 1)),
        Theme(name: "Flags", emojis: ["🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇦🇿", "🇬🇷", "🇨🇺", "🇰🇵", "🇵🇰", "🇯🇵"], numberOfPairOfCards: 5, rgbaColor: RGBAColor(red: 0.1, green: 0.1, blue: 0.9, alpha: 0.8)),
        Theme(name: "Tech", emojis: ["📱", "💻", "🖥", "🕹", "🎙", "📸", "💾"], numberOfPairOfCards: 6, rgbaColor: RGBAColor(red: 0.123, green: 0.211, blue: 0.45, alpha: 1)),
        Theme(name: "Simbols", emojis: ["🕉", "☣️", "🀄️", "👁‍🗨", "🎦", "♠️", "💮", "💝", "♦️"], numberOfPairOfCards: 7, rgbaColor: RGBAColor(red: 0.437, green: 0.115, blue: 0.45, alpha: 1))
    ]
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    init() {
        restoreFromUserDefaults()
        
        if themes.isEmpty {
            themes = ThemeStore.staticThemes
        }
    }
    
    // MARK: - Save & Load Themes
    
    private func storeInUserDefaults() {
        if let encodedThemes = try? JSONEncoder().encode(themes) {
            UserDefaults().set(encodedThemes, forKey: "Themes")
        }
    }
    
    private func restoreFromUserDefaults() {
        if let encodedThemes = UserDefaults().data(forKey: "Themes") {
            let decodedThemes = try? JSONDecoder().decode([Theme].self, from: encodedThemes)
            themes = decodedThemes ?? ThemeStore.staticThemes
        }
    }
    
    // MARK: - Intent(s)
    
    func addTheme() {
        let theme = Theme(name: "", emojis: [], numberOfPairOfCards: 0, rgbaColor: RGBAColor(red: 1, green: 1, blue: 0, alpha: 1))
        themes.append(theme)
    }
    
    func deleteThemes(at offsets: IndexSet) {
        for offset in offsets {
            themes.remove(at: offset)
        }
    }
    
    func moveThemes(fromOffset: IndexSet, toOffset: Int) {
        themes.move(fromOffsets: fromOffset, toOffset: toOffset)
    }
}
