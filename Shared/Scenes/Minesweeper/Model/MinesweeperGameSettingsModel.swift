//
//  MinesweeperGameSettingsModel.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import Foundation
import SwiftUI

class MinesweeperGameSettings: ObservableObject {
    /// The number of columns on the board
    @Published var numberOfColumns: Int = 10
    
    /// The number of rows on the board
    @Published var numberOfRows: Int = 10

    /// The total number of bombs
    @Published var numberOfBombs: Int = 10
    
    @Published var spacing: CGFloat = 2
    
    @Published var health: Int = 3

    /// The size each square should be based on the width of the screen
    var squareSize: CGFloat {
        numberOfColumns > numberOfRows ?  UIScreen.main.bounds.width / CGFloat(numberOfColumns) - spacing * CGFloat(((numberOfColumns) / (numberOfColumns-1))) :  UIScreen.main.bounds.width / CGFloat(numberOfRows) - spacing * CGFloat(((numberOfRows) / (numberOfRows-1)))
    }
    
    var numberOfSquares: Int {
        numberOfColumns * numberOfRows
    }
    
    var minNumberOfRowOrCol: Int {
        (numberOfRows - numberOfBombs) / 2
    }
}
