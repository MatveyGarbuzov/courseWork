//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 15.03.2022.
//

import Foundation
import SwiftUI

extension Text {
    func LevelDescriptionTextStyle(settings: TicTacToeGameSettings) -> some View {
        self
            .padding(5)
            .disabled(settings.isEnemyAI == false).foregroundColor(settings.isEnemyAI ? .main : .gray)
    }
}

struct TicTacToeSettingsView: View {
    @StateObject var settings = TicTacToeGameSettings()
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Play with AI 🤖", isOn: $settings.isEnemyAI.animation())
        
                if settings.isEnemyAI {
                    HStack {
                        Text("AI Difficulty")
                        Slider(
                            value: $settings.AIDifficulty,
                            in: 1...4,
                            step: 1,
                            onEditingChanged: { editing in
                                isEditing = editing
                            },
                            minimumValueLabel: Text("1"),
                            maximumValueLabel: Text("4"),
                            label: {}
                        ).padding(5)
                    }.disabled(settings.isEnemyAI == false).foregroundColor(settings.isEnemyAI ? .main : .gray)
                    Text(description).LevelDescriptionTextStyle(settings: settings)
                }
            }
            .navigationTitle("Tic Tac Toe Settings")
            
            Spacer()
        }
        
    }
    
    let description = "Inceasing level difficulty leads to AI starts to block and check for win patterns"
}

struct TicTacToeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeSettingsView()
    }
}
