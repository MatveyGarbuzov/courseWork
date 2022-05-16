//
//  TicTacToeGameSettings.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import Foundation
import SwiftUI

class TicTacToeGameSettings: ObservableObject {
    
    @Published var isEnemyAI: Bool = true
    
    @Published var animate: Bool = false
    
    @Published var AIDifficulty: Double = 1.0
    
    @Published var isFirstPlayerTurn: Bool = true
}
