//
//  ConnectFourGameModel.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import Foundation
import SwiftUI

class ConnectFourGameModel: ObservableObject {
    @Published var squares = [Square]()
    @Published var settings: ConnectFourGameSettings
    @Published var score = ScoreModel()
    
    @AppStorage(UserDefaults.gamesWonInConnectFour) var gamesWon = GameStatistics.gamesWonInConnectFour
    @AppStorage(UserDefaults.gamesLostInConnectFour) var gamesLost = GameStatistics.gamesLostInConnectFour
    
    init(from settings: ConnectFourGameSettings) {
        self.settings = settings
        let squaresCount = settings.numberOfRows * settings.numberOfColumns - 1
        for _ in 0...squaresCount {
            squares.append(Square(status: .empty))
        }
    }
    
    func resetGameBoard() {
        let squaresCount = settings.numberOfRows * settings.numberOfColumns - 1
        for i in 0...squaresCount {
            squares[i].squareStatus = .empty
        }
    }
    
    func checkWinComb(forPlayer player: SquareStatus) -> SquareStatus? {
        // Vertical
        for x in 0..<settings.numberOfRows - 3 {
            for y in 0..<settings.numberOfColumns {
               
                let winIndex = [
                    x*settings.numberOfColumns+y,
                    (x+1)*settings.numberOfColumns+y,
                    (x+2)*settings.numberOfColumns+y,
                    (x+3)*settings.numberOfColumns+y
                ]
                if squares[winIndex[0]].squareStatus == player,
                   squares[winIndex[1]].squareStatus == player,
                   squares[winIndex[2]].squareStatus == player,
                   squares[winIndex[3]].squareStatus == player {
                    print("PLAYER HAVE VERTICAL WIN COMB -> \(winIndex)")
                    return player
                }
            }
        }
        
        // Horizontal
        for x in 0..<settings.numberOfRows {
            for y in 0..<settings.numberOfColumns - 3 {
                let winIndex = [
                    x*settings.numberOfColumns+y,
                    x*settings.numberOfColumns+y+1,
                    x*settings.numberOfColumns+y+2,
                    x*settings.numberOfColumns+y+3
                ]
                if squares[winIndex[0]].squareStatus == player,
                   squares[winIndex[1]].squareStatus == player,
                   squares[winIndex[2]].squareStatus == player,
                   squares[winIndex[3]].squareStatus == player {
                    print("PLAYER HAVE HORIZONTAL WIN COMB -> \(winIndex)")
                    return player
                }
            }
        }
        
        // Diagonal UP (RIGHT)
        for x in 0..<settings.numberOfRows - 3{
            for y in 3..<settings.numberOfColumns {
                let winIndex = [
                    x*settings.numberOfColumns+y,
                    (x+1)*settings.numberOfColumns+y-1,
                    (x+2)*settings.numberOfColumns+y-2,
                    (x+3)*settings.numberOfColumns+y-3
                ]
                
                if squares[winIndex[0]].squareStatus == player,
                   squares[winIndex[1]].squareStatus == player,
                   squares[winIndex[2]].squareStatus == player,
                   squares[winIndex[3]].squareStatus == player {
                    print("PLAYER HAVE DIAGONAL UP(right) WIN COMB -> \(winIndex)")
                    return player
                }
            }
        }
        
        // Diagonal UP (LEFT)
        for x in 0..<settings.numberOfRows - 3 {
            for y in 0..<settings.numberOfColumns - 3 {
                let winIndex = [
                    x*settings.numberOfColumns+y,
                    (x+1)*settings.numberOfColumns+y+1,
                    (x+2)*settings.numberOfColumns+y+2,
                    (x+3)*settings.numberOfColumns+y+3
                ]
                
                if squares[winIndex[0]].squareStatus == player,
                   squares[winIndex[1]].squareStatus == player,
                   squares[winIndex[2]].squareStatus == player,
                   squares[winIndex[3]].squareStatus == player {
                    print("PLAYER HAVE DIAGONAL UP(left) WIN COMB -> \(winIndex)")
                    return player
                }
            }
        }
        
        print("No winnner")
        return nil

    }
    
    var gameOver : (SquareStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return(thereIsAWinner, true)
            } else {
                for i in 0...settings.numberOfColumns*settings.numberOfRows-1 {
                    if squares[i].squareStatus == .empty {
                        return(.empty, false)
                    }
                }
                return(.empty, true)
            }
        }
    }
    
    private var thereIsAWinner: SquareStatus {
        get {
            
            if let check = checkWinComb(forPlayer: .home) {
                
                print("Home win")
                return check
            } else if let check = checkWinComb(forPlayer: .visitor) {
                print("Visitor win")
                return check
            }
            return .empty
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
        if gameOver.0 == .home {
            return Text("First player win!")
        } else if gameOver.0 == .visitor {
            return Text("Second player win!")
        } else {
            return Text("Nobody win!")
        }
    }
    
    // Function return most lowest free index in the column
    private func findFreeSquareBelowThis(index: Int) -> Int {
        let squaresCount = settings.numberOfColumns * settings.numberOfRows - 1
        var checkIndexNumber = index
        var indexToPlace: Int = index
        while checkIndexNumber <= squaresCount {
            print(checkIndexNumber)
            if squares[checkIndexNumber].squareStatus == .empty {
                indexToPlace = checkIndexNumber
            } else { // if Square is occupied then, return prev. free square
                return indexToPlace
            }
            checkIndexNumber += 7
        }
        return indexToPlace
    }
    
    func makeMove(index: Int) {
        let index = findFreeSquareBelowThis(index: index)
        let player = settings.firstPlayerTurn ? SquareStatus.home : SquareStatus.visitor
        settings.animate.toggle()
        settings.firstPlayerTurn.toggle()
        if squares[index].squareStatus == .empty {
            squares[index].squareStatus = player
        }
    }
}

