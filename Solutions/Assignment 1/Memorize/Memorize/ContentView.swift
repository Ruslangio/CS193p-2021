//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 15.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            Text("Memorize!")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id:\.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            HStack {
                Spacer()
                vehicleButton
                Spacer()
                animalButton
                Spacer()
                weatherButton
                Spacer()
            }
            .padding(.bottom)
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
    
    var vehicleButton: some View {
        Button {
            emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "car.fill")
                Text("Vehicles").font(.footnote)
            }
        }
    }
    
    var animalButton: some View {
        Button {
            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🦁", "🐷"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)

        } label: {
            VStack {
                Image(systemName: "hare.fill")
                Text("Animals").font(.footnote)
            }
        }
    }
    
    var weatherButton: some View {
        Button {
            emojis = ["☀️", "🌈", "🌪", "🌤", "☁️", "🌧", "❄️", "💨"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "sun.max.fill")
                Text("Weather").font(.footnote)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
