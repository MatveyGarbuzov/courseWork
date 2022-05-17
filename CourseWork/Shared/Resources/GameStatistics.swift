//
//  GameStatistics.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 07.05.2022.
//

import Foundation
import SwiftUI

enum GameStatistics {
    //MARK: TIC TAC TOE
    static var gamesWonInTicTacToe: Int = 0
    static var gamesLostInTicTacToe: Int = 0
    
    //MARK: MINESWEEPER
    static var gamesWonInMinesweeper: Int = 0
    static var gamesLostInMinesweeper: Int = 0
    static var flagCount: Int = 0
    static var totalDeaths: Int = 0
    
    //MARK: CONNECT FOUR
    static var gamesWonInConnectFour: Int = 0
    static var gamesLostInConnectFour: Int = 0
}
