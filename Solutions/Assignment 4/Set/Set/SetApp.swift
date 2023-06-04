//
//  SetApp.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
