//
//  CardView.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

struct CardView: View {
    let card: SetGameViewModel.Card
    var isDealt = true

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardCover = RoundedRectangle(cornerRadius: 15)
                
                cardCover.foregroundColor(card.isChosen ? .gray : .white)
                
                if isDealt {
                    VStack(spacing: 0) {
                        ForEach(0..<card.number.rawValue, id: \.self) { _ in
                            shape
                                .padding(geometry.size.height / 40)
                        }
                    }
                }
            }
            .padding(1)
        }
    }

    @ViewBuilder
    private var shape: some View {
        let shape = createShape().aspectRatio(2/1, contentMode: .fit)
        switch card.color {
        case .first: shape.foregroundColor(.red)
        case .second: shape.foregroundColor(.green)
        case .third: shape.foregroundColor(.purple)
        }
    }

    @ViewBuilder
    private func createShape() -> some View {
        switch card.shape {
        case .first: fillShape(shape: Squiggle())
        case .second: fillShape(shape: Diamond())
        case .third: fillShape(shape: Capsule())
        }
    }

    @ViewBuilder
    private func fillShape<someShape>(shape: someShape) -> some View where someShape: Shape {
        switch card.shading {
        case .first: shape.fill()
        case .second: shape.stroke()
        case .third: shape.striped()
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
