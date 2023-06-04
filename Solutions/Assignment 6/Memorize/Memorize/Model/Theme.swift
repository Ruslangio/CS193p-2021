//
//  Theme.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 09.05.2023.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var emojis: [String]
    var numberOfPairOfCards: Int
    var rgbaColor: RGBAColor
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
