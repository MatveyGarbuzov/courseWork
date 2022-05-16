//
//  ScoreModel.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 15.03.2022.
//

import Foundation
import SwiftUI

final class ScoreModel: ObservableObject {
    @Published var homeScore: Int = 0
    @Published var visitorScore: Int = 0
    
    func resetScore() {
        self.homeScore = 0
        self.visitorScore = 0
    }
}
