//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 15.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
