//
//  ConnectFourQuestionView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import SwiftUI

struct ConnectFourQuestionView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("1. The game is played on a grid that's 6 squares by 7 squares.")
                }
                Section {
                    Text("2. You are playing first, your friend (or the computer) is second.")
                }
                Section {
                    Text("3. During each turn, a player add another disc from the top.")
                }
                Section {
                    Text("4. The first player to get 4 of its marks in a row (up, down, across, or diagonally) is the winner.")
                }
                Section {
                    Text("5. When all squares are full, the game is over. If no player has 4 marks in a row, the game ends in a tie.")
                }
            }
            .navigationTitle(Text("Connect Four rules 🏆"))
        }
    }
}



