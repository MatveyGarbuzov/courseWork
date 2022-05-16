//
//  Square.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import Foundation

enum SquareStatus {
    case empty
    case home
    case visitor
}

class Square : ObservableObject {
    @Published var squareStatus : SquareStatus
    
    init(status : SquareStatus) {
        self.squareStatus = status
    }
}
