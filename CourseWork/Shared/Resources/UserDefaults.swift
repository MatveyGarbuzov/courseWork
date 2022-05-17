//
//  UserDefaults.swift
//  iOS_Game (iOS)
//
//  Created by Matvey Garbuzov on 16.05.2022.
//

import Foundation

enum UserDefaults {
    // Profile
    static let name = "name"
    static let subtitle = "subtitle"
    static let description = "description"
    
    // TicTacToe
    static let gamesWonInTicTacToe  = "gamesWonInTicTacToe"
    static let gamesLostInTicTacToe = "gamesLostInTicTacToe"
    
    // Minesweeper
    static let gamesWonInMinesweeper = "gamesWonInMinesweeper"
    static let gamesLostInMinesweeper = "gamesLostInMinesweeper"
    static let totalDeaths = "totalDeaths"
    static let flagCount = "flagCount"
    
    // Connect Four
    static let gamesWonInConnectFour = "gamesWonInConnectFour"
    static let gamesLostInConnectFour = "gamesLostInConnectFour"
    
    // Profile
    static let red = "red"
    static let green = "green"
    static let blue = "blue"
    static let xp = "xp"
    static let level = "level"
}
