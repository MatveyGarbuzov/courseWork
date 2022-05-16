//
//  ConnectFourGameSettingsModel.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import Foundation
import SwiftUI

class ConnectFourGameSettings: ObservableObject {
    @Published var numberOfColumns: Int = 7
    @Published var numberOfRows: Int = 6
    @Published var spacing: CGFloat = 2
    
    @Published var firstPlayerColor: Color = Color(red: 255.0 / 255, green: 180.0 / 255, blue: 255.0 / 255, opacity: 1.0)
    @Published var secondPlayerColor: Color = Color(red: 195.0 / 255, green: 120.0 / 255, blue: 195.0 / 255, opacity: 1.0)
    
    @Published var animate: Bool = false
    
    @Published var firstPlayerTurn: Bool = true
    
    let arrayOfColorsForFirstPlayer = [
        Color(red: 255.0 / 255, green: 180.0 / 255, blue: 255.0 / 255, opacity: 1.0),
        Color(red: 255.0 / 255, green: 180.0 / 255, blue: 119.0 / 255, opacity: 1.0),
        Color(red: 123.0 / 255, green: 180.0 / 255, blue: 119.0 / 255, opacity: 1.0),
        Color(red: 138.0 / 255, green: 154.0 / 255, blue: 255.0 / 255, opacity: 1.0),
        Color(red: 225.0 / 255, green: 88.0 / 255, blue: 40.0 / 255, opacity: 1.0),
        Color(red: 76.0 / 255, green: 249.0 / 255, blue: 193.0 / 255, opacity: 1.0),
        Color(red: 105.0 / 255, green: 0.0 / 255, blue: 255.0 / 255, opacity: 1.0)
    ]
    let arrayOfColorsForSecondPlayer = [
        Color(red: 195.0 / 255, green: 120.0 / 255, blue: 195.0 / 255, opacity: 1.0),
        Color(red: 195.0 / 255, green: 120.0 / 255, blue: 69.0 / 255, opacity: 1.0),
        Color(red: 73.0 / 255, green: 120.0 / 255, blue: 69.0 / 255, opacity: 1.0),
        Color(red: 88.0 / 255, green: 104.0 / 255, blue: 185.0 / 255, opacity: 1.0),
        Color(red: 165.0 / 255, green: 38.0 / 255, blue: 4.0 / 255, opacity: 1.0),
        Color(red: 36.0 / 255, green: 199.0 / 255, blue: 143.0 / 255, opacity: 1.0),
        Color(red: 55.0 / 255, green: 20.0 / 255, blue: 235.0 / 255, opacity: 1.0)
    ]
    
    var squareSize: CGFloat {
      UIScreen.main.bounds.width / CGFloat(numberOfColumns) - spacing * CGFloat(CGFloat(numberOfColumns - 1))
    }
    
//    var squareSize: CGFloat {
//        numberOfColumns > numberOfRows ?
//            UIScreen.main.bounds.width / CGFloat(numberOfColumns) - spacing * CGFloat(CGFloat(numberOfColumns-1)) :
//            UIScreen.main.bounds.width / CGFloat(numberOfRows) - spacing * CGFloat(CGFloat(numberOfRows-1))
//    }
}
