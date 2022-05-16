//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 15.03.2022.
//

import Foundation
import SwiftUI

struct TicTacToeView: View {
    @EnvironmentObject var game: TicTacToeGameModel
    @StateObject var score = ScoreModel()
    
    @State var gameOver: Bool = false
    @State var showSettingsView: Bool = false
    @State var showQuestionView: Bool = false
    @State private var angle: Double = 0
    
    func buttonAction(_ index : Int) {
        if game.settings.isEnemyAI { // gamemode with bot
            _ = self.game.makeMove(index: index, player: .home)
        } else if game.squares[index].squareStatus == .empty {
            self.game.makeMove(index: index)
        }
        self.gameOver = self.game.gameOver.1 // Check if the game end
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // GameScore
                TicTacToeTextInfo(settings: game.settings, score: game.score)
                // GameBoard
                ForEach(0 ..< game.squares.count / 3, content: { row in
                    HStack {
                        ForEach(0 ..< 3, content: { column in
                            let index = row * 3 + column
                            TicTacToeSquareView(
                                dataSource: game.squares[index],
                                action: { self.buttonAction(index) },
                                size: UIScreen.main.bounds.size.width / 3 * 0.6
                            )
                        })
                    }
                })
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color.BG).ignoresSafeArea()
            .alert(isPresented: self.$gameOver, content: { gameOverAlert })
            .navigationBarItems(
                leading: HStack { settingsButton; resetButton },
                trailing: questionButton
            )
        }.sheet(isPresented: $showSettingsView) {
            TicTacToeSettingsView(settings: game.settings)
        }.sheet(isPresented: $showQuestionView) {
            TicTacToeQuestionView()
        }
    }
    
    var gameOverAlert: Alert {
        Alert(
            title: Text("Game Over"),
            message: gameOverText,
            dismissButton: dismissButton
        )
    }
    
    var dismissButton: Alert.Button {
        Alert.Button.destructive(Text("Ok"), action: {
            game.addScore()
            game.resetGameBoard()
        })
    }
    
    var gameOverText: Text {
        return game.winnerText()
    }
    
    var settingsButton: some View {
        Button(action: {
            print("Settings button pressed.")
            self.showSettingsView.toggle()
        }) {
            Image(systemName: "gearshape.fill").imageScale(.large).foregroundColor(.main)
        }
    }
    
    var resetButton: some View {
        Button(action: {
            print("Reset button pressed.")
            game.score.resetScore()
            game.resetGameBoard()
            angle -= 360
        }) {
            Image(systemName: "gobackward").imageScale(.large).foregroundColor(.main)
        }.rotationEffect(.degrees(angle))
        .animation(.easeIn, value: angle)
    }
    
    var questionButton: some View {
        Button(action: {
            print("Questionmark button pressed.")
            self.showQuestionView.toggle()
        }) {
            Image(systemName: "questionmark.circle.fill").imageScale(.large).foregroundColor(.main)
        }
    }
}

struct TicTacToeTextInfo: View {
    @StateObject var settings: TicTacToeGameSettings
    @ObservedObject var score: ScoreModel
    @State private var angle: Double = 0.0
    
    
    var body: some View {
        HStack {
            // First player score
            HStack {
                Text("X")
                    .NameScoreStyle()
                Text("Score: \(score.homeScore)")
            }.padding(.leading, 10)
            
            Spacer()
            
            // Arrow pointing on player that can make move
            Image(systemName: settings.isEnemyAI ? "" : "arrow.left")
                .ArrowStyle(settings: settings)
            
            Spacer()
            
            // Second player score
            HStack {
                Text("O")
                    .NameScoreStyle()
                Text("Score: \(score.visitorScore)")
            }.padding(.trailing, 10)
        }
        .frame(height: 45)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.greyBG).opacity(0.75))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
