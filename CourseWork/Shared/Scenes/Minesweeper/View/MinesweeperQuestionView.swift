//
//  MinesweeperQuestionView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import SwiftUI

struct MinesweeperQuestionView: View {
    var body: some View {
        NavigationView {
//            Text("Minesweeper rules")
//                .bold()
//                .font(.title)
            Form {
                Section {
                    Text("1. The game of Minesweeper begins when the player makes the first click on a board with all cells unopened.")
                }
                Section {
                    Text("2. During the game, the player uses information given from the opened cells to deduce further cells that are safe to open, iteratively gaining more information to solve the board.")
                }
                Section {
                    Text("3. Frequently when playing the game, the player encounters situations when they cannot deduce any further safe cells from the information given so they would need to make a guess. Good luck!.")
                }
                Section {
                    Text("4. To win the game, players must open all non-mine cells while not opening any mines. Flagging all the mined cells is not required.")
                }
            }
            .navigationTitle(Text("Minesweeper rules 🏆"))
        }
        
    }
}

struct MinesweeperQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        MinesweeperQuestionView()
    }
}
