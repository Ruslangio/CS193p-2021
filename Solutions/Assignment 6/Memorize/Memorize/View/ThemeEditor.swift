//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Ruslan Alekyan on 09.05.2023.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationStack {
            Form {
                nameSection
                emojisSection
                addEmojiSection
                pairOfCardsSection
                colorSection
            }
            .navigationTitle(theme.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    doneButton
                }
            }
        }
    }
    
    private var nameSection: some View {
        Section("Name") {
            TextField("Name", text: $theme.name)
        }
    }
    
    private var emojisSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if theme.emojis.count > theme.numberOfPairOfCards {
                                    theme.emojis.removeAll(where: { $0 == emoji } )
                                }
                            }
                        }
                }
                .font(.system(size: 40))
            }
        } header: {
            HStack {
                Text("Emojis")
                Spacer()
                Text("Tap emoji to exclude")
            }
        }
    }
    
    @State private var emojisToAdd = ""
    
    private var addEmojiSection: some View {
        Section("Add emoji") {
            TextField("Emoji", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    emojis.forEach { emoji in
                        if emoji.isEmoji && !theme.emojis.contains(String(emoji)) {
                            theme.emojis.append(String(emoji))
                        }
                    }
                }
        }
    }
    
    private var pairOfCardsSection: some View {
        Section("Card count") {
            Stepper("\(theme.numberOfPairOfCards) Pairs", value: $theme.numberOfPairOfCards, in: min(2, theme.emojis.count)...theme.emojis.count)
        }
    }
    
    private var colorSection: some View {
        Section("Color") {
            ColorPicker("Color", selection: $theme.color)
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            dismiss()
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore.staticThemes[0]))
    }
}
