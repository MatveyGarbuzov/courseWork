//
//  MinesweeperGameModel.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import Foundation

class MinesweeperGameModel: ObservableObject {
    @Published var settings: MinesweeperGameSettings
    @Published var board: [[MinesweeperCell]]
    @Published var showResult: Bool = false
    @Published var isWon: Bool = false;
    
    init(from settings: MinesweeperGameSettings) {
        self.settings = settings
        board = Self.generateBoard(from: settings)
    }
    
    func isPlayerWon() -> Bool {
        for row in 0..<settings.numberOfRows {
            for col in 0..<settings.numberOfColumns{
                // If board contains normal cell, it means game is still going on.
                if(board[row][col].status == .normal){
                    return false
                }
            }
        }
        return true
    }

    func click(on cell: MinesweeperCell) {
        // If cell is opened or flagged, then skip the click
        if cell.isOpened || cell.isFlagged {
            return
        }
        
        // Check we didn't click on a bomb
        if cell.status == .bomb {
            print("BOOOM")
            cell.isOpened = true
            settings.health -= 1
            if settings.health == 0 {
                print("LOSE")
                showResult = true
                isWon = false;
            }
        } else {
            reveal(for: cell)
        }
        if isPlayerWon() {
            showResult = true
            isWon = true
        }
        self.objectWillChange.send()
    }

    func toggleFlag(on cell: MinesweeperCell) {
        guard !cell.isOpened else {
            return
        }

        cell.isFlagged = !cell.isFlagged
        if(isPlayerWon()){
            showResult = true
            isWon = true
        }

        self.objectWillChange.send()
    }

    func reset() {
        settings.health = 3
        board = Self.generateBoard(from: settings)
        showResult = false
        isWon = false
    }

    // MARK: - Private Functions
    private func reveal(for cell: MinesweeperCell) {
        guard !cell.isOpened else { return }

        guard !cell.isFlagged else { return }

        guard cell.status != .bomb else { return }

        let exposedCount = getExposedCount(for: cell)

        if cell.status != .bomb {
            cell.status = .exposed(exposedCount)
            cell.isOpened = true
        }

        if (exposedCount == 0) {
            // get the neighboring cells (top, bottom, left and right)
            // make sure they aren't passed the size of our board
            let topCell = board[max(0, cell.row - 1)][cell.column]
            let bottomCell = board[min(cell.row + 1, board.count - 1)][cell.column]
            let leftCell = board[cell.row][max(0, cell.column - 1)]
            let rightCell = board[cell.row][min(cell.column + 1, board[0].count - 1)]

            reveal(for: topCell)
            reveal(for: bottomCell)
            reveal(for: leftCell)
            reveal(for: rightCell)
        }
    }

    /// Get the number of bombs that are neighboring the cell
    /// - Parameters:
    ///   - cell: The cell to get the exposed count for
    /// - Returns: The number of bombs that neighbor the cell
    private func getExposedCount(for cell: MinesweeperCell) -> Int {
        let row = cell.row
        let col = cell.column

        let minRow = max(row - 1, 0)
        let minCol = max(col - 1, 0)
        let maxRow = min(row + 1, board.count - 1)
        let maxCol = min(col + 1, board[0].count - 1)

        var totalBombCount = 0
        for row in minRow...maxRow {
            for col in minCol...maxCol {
                if board[row][col].status == .bomb {
                    totalBombCount += 1
                }
            }
        }

        return totalBombCount
    }

    /// Generate the board with the given number of boms
    /// - Parameter settings: The game settings to create the board from
    /// - Returns: 2D array of cells from which the starting game will be played
    private static func generateBoard(from settings: MinesweeperGameSettings) -> [[MinesweeperCell]] {
        var newBoard = [[MinesweeperCell]]()

        for row in 0..<settings.numberOfRows {
            var column = [MinesweeperCell]()

            for col in 0..<settings.numberOfColumns {
                column.append(MinesweeperCell(row: row, column: col))
            }

            newBoard.append(column)
        }

        var numberOfBombsPlaced = 0
        while numberOfBombsPlaced < settings.numberOfBombs {
            // Generate a random number that will fall somewhere in our board
            let randomRow = Int.random(in: 0..<settings.numberOfRows)
            let randomCol = Int.random(in: 0..<settings.numberOfColumns)

            let currentRandomCellStatus = newBoard[randomRow][randomCol].status
            if currentRandomCellStatus != .bomb {
                newBoard[randomRow][randomCol].status = .bomb
                numberOfBombsPlaced += 1
            }
        }

        return newBoard
    }
}
