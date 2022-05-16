//
//  CellView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import SwiftUI

struct MinesweeperSquareView: View {
    // Our game will live at the top most level
    // which will prevent us from having to pass around a game object
    // to subviews
    // Since we are a subview, we have access to the EnvObject here.
    @EnvironmentObject var game: MinesweeperGameModel
    var cell: MinesweeperCell
    
    @AppStorage(UserDefaults.gamesWonInMinesweeper) var gamesWonInMinesweeper = GameStatistics.gamesWonInMinesweeper
    @AppStorage(UserDefaults.gamesLostInMinesweeper) var gamesLostInMinesweeper = GameStatistics.gamesLostInMinesweeper
    @AppStorage(UserDefaults.totalDeaths) var totalDeaths = GameStatistics.totalDeaths
    @AppStorage(UserDefaults.flagCount) var flagCount = GameStatistics.flagCount

    var body: some View {
        cell.image
            .resizable()
            .scaledToFill()
            .frame(width: game.settings.squareSize,
                   height: game.settings.squareSize,
                   alignment: .center)
            .onTapGesture {
                game.click(on: cell)
                if game.isPlayerWon() {
                    print("WON!")
                    gamesWonInMinesweeper += 1
                }
                if game.settings.health == 0 {
                    gamesLostInMinesweeper += 1
                }
                if cell.status == .bomb {
                    totalDeaths += 1
                }
                print("TAPPED")
            }
            .onTapGesture(count: 2, perform: {
                game.toggleFlag(on: cell)
            })
            .onLongPressGesture {
                if !cell.isFlagged {
                    flagCount += 1
                }
                game.toggleFlag(on: cell)
            }
    }
}
