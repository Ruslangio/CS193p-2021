//
//  SetGameView.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .padding()
            
            HStack {
                Button("Deal 3 cards") {
                    game.dealThreeCards()
                }
                .disabled(game.cards.count == 21 || game.isDeckEmpty)
                Spacer()
                Button("Restart") {
                    game.restart()
                }
            }
            .padding()
        }
        .background(.black)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
