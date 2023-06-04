//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 09.05.2023.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var themeStore: ThemeStore
    
    @State private var editMode: EditMode = .inactive
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(themeStore.themes) { theme in
                    NavigationLink {
                        EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))
                    } label: {
                        gameRow(for: theme)
                    }
                    .gesture(editMode == .active ? tapGesture(theme: theme) : nil)
                }
                .onDelete(perform: themeStore.deleteThemes)
                .onMove(perform: themeStore.moveThemes)
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $themeToEdit) { theme in
                ThemeEditor(theme: $themeStore.themes[theme])
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    private func gameRow(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .foregroundColor(theme.color)
            if theme.emojis.count == theme.numberOfPairOfCards {
                Text("All of \(theme.emojis.joined())")
            } else {
                Text("\(theme.numberOfPairOfCards) pairs of \(theme.emojis.joined())")
            }
        }
    }
    
    private var addButton: some View {
        Button {
            themeStore.addTheme()
            themeToEdit = themeStore.themes.last
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func tapGesture(theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                themeToEdit = theme
            }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser(themeStore: ThemeStore())
    }
}
