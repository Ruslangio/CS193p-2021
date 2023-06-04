//
//  SetGame.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import Foundation   

struct SetGame {
    private(set) var deck: [Card]                                                         // Колода карт
    private(set) var cards: [Card]                                                        // Карты на экране
    
    private var chosenIndices: [Int] { cards.indices.filter { cards[$0].isChosen} }       // Индексы выбранных карт
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isMatched {        // Индекс выбранной карты, нельзя выбрать совпавшую карту
            
            if chosenIndices.count == 2, !cards[chosenIndex].isChosen {                                           // Если выбрано 2 карты и выбирается другая карта
                cards[chosenIndex].isChosen = true
                
                if checkSet(of: chosenIndices) {                                 // Проверка на соотвествие сету
                    for index in chosenIndices {
                        cards[index].isMatched = true
                        
                    }
                    
                    let idOfCards = chosenIndices.map { cards[$0].id }                  // ПОСЛЕДНЕЕ ИЗМЕНЕНИЕ
                    cards.removeAll(where: { idOfCards.contains($0.id) } )
                    
                    if deck.count != 0, cards.count < 12 {
                        dealThreeCards()
                    }
                }
                for index in chosenIndices {                                        // Выбранных карт не остается
                    cards[index].isChosen = false
                }
            } else {                                                               // Если выбранных карт меньше 2, то выбирается карта
                cards[chosenIndex].isChosen.toggle()
            }
        }
    }
    
    private func checkSet(of indices: [Int]) -> Bool {
        var colors = Set<Variant>()
        var shapes = Set<Variant>()
        var shadings = Set<Variant>()
        var numbers = Set<Variant>()
        
        indices.forEach { card in
            colors.insert(cards[card].color)
            shapes.insert(cards[card].shape)
            shadings.insert(cards[card].shading)
            numbers.insert(cards[card].number)
        }
        
        return colors.count != 2 && shapes.count != 2 && shadings.count != 2 && numbers.count != 2
    }
    
    mutating func dealThreeCards() {
        guard cards.count < 21 else { return }
        for _ in 1...3 {
            cards.append(deck.removeFirst())
        }
    }
    
    init() {
        deck = []
        cards = []
        var id = 1
        for color in Variant.allCases {
            for shape in Variant.allCases {
                for shading in Variant.allCases {
                    for number in Variant.allCases {
                        deck.append(Card(id: id, color: color, shape: shape, shading: shading, number: number))
                        id += 1
                    }
                }
            }
        }
        deck.shuffle()
        for _ in 1...12 {
            cards.append(deck.removeFirst())
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        var isChosen = false
        var isMatched = false
        let color: Variant
        let shape: Variant
        let shading: Variant
        let number: Variant
    }
    
    enum Variant: Int, CaseIterable {
        case first = 1
        case second = 2
        case third = 3
    }
}
