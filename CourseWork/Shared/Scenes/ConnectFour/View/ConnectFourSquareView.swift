//
//  ConnectFourSquareView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import SwiftUI

struct ConnectFourSquareView : View {
    @EnvironmentObject var game: ConnectFourGameModel
    @ObservedObject var dataSource : Square
    
    var action: () -> Void
    var size: CGFloat
    var settings: ConnectFourGameSettings
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Circle()
                .frame(width: game.settings.squareSize,
                       height: game.settings.squareSize,
                       alignment: .center)
                .foregroundColor(self.dataSource.squareStatus == .home ? settings.firstPlayerColor : self.dataSource.squareStatus == .visitor ? settings.secondPlayerColor : .main.opacity(0.15))
        })
    }
}
