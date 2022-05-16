//
//  QuestionView.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 15.03.2022.
//

import Foundation
import SwiftUI

struct TicTacToeQuestionView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("1. The game is played on a grid that's 3 squares by 3 squares.")
                }
                Section {
                    Text("2. You are X, your friend (or the computer) is O. Players take turns putting their marks in empty squares.")
                }
                Section {
                    Text("3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.")
                }
                Section {
                    Text("4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.")
                }
            }
            .navigationTitle(Text("Tic Tac Toe rules 🏆"))
        }
        
    }
}
