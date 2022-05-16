//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 14.03.2022.
//

import Foundation
import SwiftUI

class TicTacToeGameModel : ObservableObject {
    @Published var squares = [Square]()
    @Published var settings: TicTacToeGameSettings
    @Published var score = ScoreModel()
    
    @AppStorage(UserDefaults.gamesWonInTicTacToe) var gamesWon = GameStatistics.gamesWonInTicTacToe
    @AppStorage(UserDefaults.gamesLostInTicTacToe) var gamesLost = GameStatistics.gamesLostInTicTacToe
    
    init(from settings: TicTacToeGameSettings) {
        self.settings = settings
        for _ in 0...8 {
            squares.append(Square(status: .empty))
        }
    }
    
    func resetGameBoard() {
        for i in 0...8 {
            squares[i].squareStatus = .empty
        }
    }
    
    var gameOver : (SquareStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return (thereIsAWinner, true)
            } else {
                for i in 0...8 {
                    if squares[i].squareStatus == .empty {
                        return(.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }
    
    func addScore() {
        if gameOver.0 == .home {
            score.homeScore += 1
            gamesWon += 1
        } else if gameOver.0 == .visitor {
            score.visitorScore += 1
            gamesLost += 1
        }
    }
    
    func winnerText() -> Text {
        if gameOver.0 != .empty {
            if gameOver.0 == .home {
                return settings.isEnemyAI ? Text("You win!") : Text("First player win!")
            } else {
                return settings.isEnemyAI ? Text("AI win!") : Text("Second player win!")
            }
        } else {
            return Text("Nobody wins")
        }
    }
    
    private var thereIsAWinner: SquareStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2], 3) {
                return check
            } else if let check = self.checkIndexes([3, 4, 5], 3) {
                return check
            }  else if let check = self.checkIndexes([6, 7, 8], 3) {
                return check
            }  else if let check = self.checkIndexes([0, 3, 6], 3) {
                return check
            }  else if let check = self.checkIndexes([1, 4, 7], 3) {
                return check
            }  else if let check = self.checkIndexes([2, 5, 8], 3) {
                return check
            }  else if let check = self.checkIndexes([0, 4, 8], 3) {
                return check
            }  else if let check = self.checkIndexes([2, 4, 6], 3) {
                return check
            }
            return .empty
        }
    }
    
    private func checkIndexes(_ indexes: [Int], _ inARow: Int) -> SquareStatus? {
        var homeCounter : Int = 0
        var visitorCounter : Int = 0
        for index in indexes {
            let square = squares[index]
            if square.squareStatus == .home {
                homeCounter += 1
            } else if square.squareStatus == .visitor {
                visitorCounter += 1
            }
        }
        if homeCounter == inARow {
            return .home
        } else if visitorCounter == inARow {
            return .visitor
        }
        return nil
    }
    
    private func moveAI() {
        let difficulty = settings.AIDifficulty
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
            [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
        ]
        
        // If AI can win, then win :)
        if difficulty == 4 {
            for pattern in winPatterns {
                if let check = checkIndexes(pattern, 2) {
                    if check == .visitor  {
                        for index in pattern {
                            if squares[index].squareStatus == .empty {
                                _ = makeMove(index: index, player: .visitor)
                                print("AI SHOUD GO TO INDEX: \(index)")
                                return
                            }
                        }
                    }
                }
            }
        }
        
        
        // If AI can't win, then block
        if difficulty >= 3 {
            for pattern in winPatterns {
                if let check = checkIndexes(pattern, 2) {
                    if check == .home  {
                        for index in pattern {
                            if squares[index].squareStatus == .empty {
                                _ = makeMove(index: index, player: .visitor)
                                print("AI SHOUD BLOCK TO INDEX: \(index)")
                                return
                            }
                        }
                    }
                }
            }
        }
        
        
        // If AI can't block, then place in the middle square
        if difficulty >= 2 {
            let centerSquare = 4
            if squares[centerSquare].squareStatus == .empty {
                _ = makeMove(index: centerSquare, player: .visitor)
                print("AI SHOUD BLOCK TO INDEX: \(centerSquare)")
                return
            }
        }
        
        // Or make random move
        if difficulty >= 1 {
            var index = Int.random(in: 0...8)
            while makeMove(index: index, player: .visitor) == false && gameOver.1 == false {
                print("RANDOM MOVE")
                index = Int.random(in: 0...8)
            }
        }
    }
    
    func makeMove(index: Int, player: SquareStatus) -> Bool {
        if squares[index].squareStatus == .empty {
            squares[index].squareStatus = player
            // If prev. turn was home player and gamemode is AI, then AI can move
            if player == .home && settings.isEnemyAI {
                if !gameOver.1 { // If game isn't over then AI make move
                    self.moveAI()
                }
            }
            return true
        }
        return false
    }
    
    func makeMove(index: Int) {
        let player = settings.isFirstPlayerTurn ? SquareStatus.home : SquareStatus.visitor
        settings.animate.toggle()
        settings.isFirstPlayerTurn.toggle()
        if squares[index].squareStatus == .empty {
            squares[index].squareStatus = player
        }
    }
}
