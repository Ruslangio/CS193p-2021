//
//  SetGameView.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    @Namespace private var deckNamespace
    
    var body: some View {
        VStack {
            gameBody
            
            HStack {
                Spacer()
                deckBody
                Spacer()
                restartButton
                Spacer()
                discardPileBody
                Spacer()
            }
            .padding()
        }
        .background(.black)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: deckNamespace)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.2)) {
                        game.choose(card)
                    }
                }
        }
        .padding()
    }
    
    var deckBody: some View {
        VStack(spacing: 0) {
            Text("Deck")
            ZStack {
                ForEach(game.deck) { card in
                    CardView(card: card, isDealt: false)
                        .matchedGeometryEffect(id: card.id, in: deckNamespace)
                }
            }
            .frame(width: 60, height: 90)
            .onTapGesture {
                withAnimation {
                    game.dealThreeCards()
                }
            }
        }
    }
    
    var discardPileBody: some View {
        VStack(spacing: 0) {
            Text("Discard Pile")
            ZStack {
                ForEach(game.discardPile) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: deckNamespace)
                }
            }
            .frame(width: 60, height: 90)
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game.restart()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
