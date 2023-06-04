//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Ruslan Alekyan on 29.04.2023.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
