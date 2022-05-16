//
//  MinesweeperSettingsView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import SwiftUI

extension Stepper {
    func customPadding() -> some View {
        self
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
}

struct MinesweeperSettingsView: View {
    @StateObject var gameSettings: MinesweeperGameSettings
    
    var body: some View {
        NavigationView {
            Form {
                Stepper(
                    value: $gameSettings.numberOfBombs,
                    in: 1...gameSettings.numberOfSquares,
                    step: 1) {
                    Text("Bombs count: \(gameSettings.numberOfBombs)")
                }
                .padding(5)
                
                Stepper(
                    value: $gameSettings.numberOfRows,
                    in: 1...10,
                    step: 1) {
                    Text("Rows count: \(gameSettings.numberOfRows)")
                }
                .padding(5)
    
                Stepper(
                    value: $gameSettings.numberOfColumns,
                    in: 1...10,
                    step: 1) {
                    Text("Columns count: \(gameSettings.numberOfColumns)")
                }
                .padding(5)

            }
            .navigationTitle("Minesweeper Settings")
            
            Spacer()
        }
        
    }
}

struct MinesweeperSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MinesweeperSettingsView(gameSettings: MinesweeperGameSettings())
    }
}
